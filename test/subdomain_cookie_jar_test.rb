require File.join(File.dirname(__FILE__), 'test_helper')

class SubdomainCookieJarTest < Test::Unit::TestCase
  def setup
    @request = OpenStruct.new(:cookies => Hash.new)
    @response = OpenStruct.new(:headers => { "cookie" => [] })
    @controller = OpenStruct.new(:request => @request, :response => @response)
    @cookies = ActionController::CookieJar.new(@controller)
  end

  context "if domain is provided" do
    should "not do anyhing for domain as symbol" do
      @cookies["fanta"] = {:value => "wanna fanta", :domain => 'foo.bar'}
      assert_equal 'foo.bar', domain_for_the_first_cookie_found
    end

    should "not do anyhing for domain as string" do
      @cookies["fanta"] = {:value => "wanna fanta", 'domain' => 'foo.bar'}
      assert_equal 'foo.bar', domain_for_the_first_cookie_found
    end
  end

  context "if domain is not provided" do
    should "set the domain to request.host but with subdomain support" do
      @request.expects(:host).returns('foo-bar.baz')
      @cookies["fanta"] = {:value => "wanna fanta"}
      assert_equal '.foo-bar.baz', domain_for_the_first_cookie_found
    end

    should "remove subdomains" do
      @request.expects(:host).returns('thomas.f00.bar')
      @cookies["fanta"] = {:value => "wanna fanta"}
      assert_equal '.f00.bar', domain_for_the_first_cookie_found
    end

    should "do nothing for one word hosts" do
      @request.expects(:host).returns('localhost')
      @cookies["fanta"] = {:value => "wanna fanta"}
      assert_nil domain_for_the_first_cookie_found
    end
  end

  def domain_for_the_first_cookie_found
    @response.headers["cookie"].first.domain
  end
end
