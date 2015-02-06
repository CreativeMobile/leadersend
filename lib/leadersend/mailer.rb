module Leadersend
  class Mail
    def initialize to: nil, from: nil, fromname: nil, subject: "System", template_path: nil, locals: {}, title: "System"
      @api_email_url = Leadersend.config.api_url
      @api_user = Leadersend.config.username
      @api_key = Leadersend.config.api_key
      @to = to
      @subject = subject
      @template_path = template_path
      @locals = locals
      @title = title
      @from = from
      @fromname = fromname
      @template_path = template_path

      if @template_path
        @template = ApplicationController.new.render_to_string(:partial => @template_path, :locals => @locals )
      end
    end

    def send
      result = call_api
      status = (result[0] && result[0]["status"]) ? result[0]["status"] : "error"
      return {
        title: @title,
        body: @template,
        status: status,
        subject: @subject,
        to_address: @to,
        response: result.inspect
      }
    end

    def call_api
      subject = @subject
      fromname = @fromname
      options = {method: "messagesSend", apikey: @api_key, to: {email: @to}, subject: @subject, html: @template, from: {name: @fromname, email: @from}, auto_plain: true}
      resp = post_api @api_email_url, options
      json = JSON.parse(resp)
      puts json
      return json
    rescue => e
      return [{"status" => "error", "description" => "<#{e.class.name}>: #{e.message}"}]
    end

    private

      def post_api url, params
        uri = URI.parse(url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = false
        form_params = params.to_query
        res = http.post(uri.request_uri, form_params)
        res.body
      end

  end
end
