module ThumbleMonks
  module SsoWhat
    module DomainOverride
      def self.included(klass)
        klass.alias_method_chain :set_cookie, :domain_override
      end

      def set_cookie_with_domain_override(key, value)
        value = {:value => value} unless value.is_a?(Hash)
        domain_requested, host = value[:domain], request.host
        unless domain_requested || host_has_no_tld?(host)
          domain_requested = host.gsub(/^(.*\.)?([a-z0-9-]+\.[a-z]+)$/i, '\2')
          value[:domain] = ".#{domain_requested}"
        end
        set_cookie_without_domain_override(key, value)
      end

    private

      def host_has_no_tld?(host)
        host =~ /^[a-z0-9-]+$/i
      end
    end # DomainOverride
  end # SsoWhat
end # ThumbleMonks

Rack::Response.instance_eval { include ThumbleMonks::SsoWhat::DomainOverride }
