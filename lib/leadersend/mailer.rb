module Leadersend
  class Mail
    def initialize(to: nil, from: nil, fromname: nil, subject: "System", template_path: nil, locals: {}, title: "System", template: "", attachments: [])
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
      @template = template
      @attachments = Array.wrap(attachments)

      if @template_path
        @template = ApplicationController.new.render_to_string(:partial => @template_path, :locals => @locals )
      end

      @signing_domain = @from.split("@").last if @from.present?
    end

    def send
      result = call_api
      status = (result[0] && result[0]["status"]) ? result[0]["status"] : "error"

      {
        title: @title,
        body: @template,
        status: status,
        subject: @subject,
        to_address: @to,
        response: result
      }
    end

    def call_api
      subject = @subject
      fromname = @fromname
      options = {
        method: "messagesSend",
        apikey: @api_key,
        to: {
          email: @to
        },
        subject: @subject,
        html: @template,
        from: {
          name: @fromname,
          email: @from
        },
        auto_plain: true
      }

      options.merge!(signing_domain: @signing_domain) if @signing_domain.present?
      options.merge!(attachments: @attachments) if @attachments.present?

      resp = post_api(@api_email_url, options)
      JSON.parse(resp)
    rescue => e
      [{"status" => "error", "description" => "<#{e.class.name}>: #{e.message}"}]
    end

    private

    def post_api(url, params)
      uri = URI.parse(url)
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = params.to_json

      res = Net::HTTP.start(uri.host, uri.port) do |http|
        http.request(req)
      end

      res.body
    end
  end
end
