require File.join(File.dirname(__FILE__), 'test_helper')

class BaseDomainSessionTest < Test::Unit::TestCase
  # Macros

  def self.store_with_multi_domain(multi_domain_option, &block)
    context "session store with multi-domain set to #{multi_domain_option.inspect}" do
      setup do
        @response = [nil, {"Set-Cookie" => nil}] # second element is the header
        @app = stub(:call => @response)
        options = {:base_domain => multi_domain_option, :expire_after => 3600}
        @store = TestSessionStore.new(@app, options)
      end
      yield if block_given?
    end
  end

  def self.should_expect_cookie_domain_for_http_host(http_host, cookie_domain)
    should "return #{cookie_domain} for #{http_host}" do
      env = {"HTTP_HOST" => http_host}
      @store.call(env)
      expected = cookie_domain.nil? ? nil : "domain=#{cookie_domain}"
      assert_equal expected, domain_for_the_first_cookie_found
    end
  end

  def domain_for_the_first_cookie_found
    set_cookie = @response[1]["Set-Cookie"]
    set_cookie && set_cookie.scan(/domain=[a-z0-9.-]+/i).first
  end

  # Tests

  store_with_multi_domain(true) do
    should_expect_cookie_domain_for_http_host "foohost", nil
    should_expect_cookie_domain_for_http_host "foohost.bar", ".foohost.bar"
    should_expect_cookie_domain_for_http_host "gah.foohost.bar", ".foohost.bar"
    should_expect_cookie_domain_for_http_host "publisher.gah.foohost.bar", ".foohost.bar"
    should_expect_cookie_domain_for_http_host "gah.foohost.bar:3000", ".foohost.bar"
  end
  
  store_with_multi_domain(false) do
    should_expect_cookie_domain_for_http_host "gah.foohost.bar", nil
  end

  store_with_multi_domain(nil) do
    should_expect_cookie_domain_for_http_host "gah.foohost.bar", nil
  end

end

class TestSessionStore < ActionController::Session::AbstractStore
  def get_session(env, sid)
    [sid, {:foo => "bar"}]
  end

  def set_session(env, sid, session_data)
    true
  end
end
