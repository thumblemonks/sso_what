# SsoWhat
module Centro
  module BaseHost
    module CgiRequestExtensions
      
      def self.included(base)
        base.instance_eval do
          alias_method_chain :session_options_with_string_keys, :overridden_domain
        end
      end
      
      def default_session_domain
        return @session_options[:session_domain] unless @session_options[:session_domain] == :base_host
        @default_session_domain ||= base_host_for_requested_host
      end
      
      def base_host_for_requested_host
        md = host.match(/([^.]+\.)?([^.]+)$/)
        md[1].nil? ? nil : md[0]
      end
      
    private
      def session_options_with_string_keys_with_overridden_domain
        opts = session_options_with_string_keys_without_overridden_domain
        opts['session_domain'] = default_session_domain
        opts
      end

    end
  end
end

ActionController::CgiRequest.instance_eval { include Centro::BaseHost::CgiRequestExtensions }