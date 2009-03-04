class ActionController::CookieJar
private
  def set_cookie_with_domain_override(options)
    domain = options['domain'] || options[:domain]
    host = @controller.request.host
    unless domain || host =~ /^[a-z0-9-]+$/i
      domain = host.gsub(/^(.*\.)?([a-z0-9-]+\.[a-z]+)$/i, '\2')
      options['domain'] = ".#{domain}"
    end
    set_cookie_without_domain_override(options)
  end
  alias_method_chain :set_cookie, :domain_override
end
