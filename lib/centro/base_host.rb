module Centro
  module AbstractStore
    module MultiDomain
      def self.included(klass)
        klass.alias_method_chain :call, :domain_override
      end
    
      def call_with_domain_override(env)
        if @default_options[:multi_domain]
          base_host = env["HTTP_HOST"].scan(/[0-9a-z-]+\.[0-9a-z-]+(?=:|$)/i).first
          @default_options[:domain] = base_host ? ".#{base_host}" : base_host
        end
        call_without_domain_override(env)
      end
    end # MultiDomain
  end # AbstractStore
end # Centro

ActionController::Session::AbstractStore.instance_eval { include Centro::AbstractStore::MultiDomain }
