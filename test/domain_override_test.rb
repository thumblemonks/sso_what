require File.join(File.dirname(__FILE__), 'test_helper')

class DomainOverrideTest < Test::Unit::TestCase
  def setup
    # @response = OpenStruct.new(:headers => { "Set-Cookie" => [] })
    # @controller = OpenStruct.new(:request => @request, :response => @response)
    @test_request = OpenStruct.new
    @response = Rack::Response.new
    @response.stubs(:request).returns(@test_request)
  end

  context "if domain is provided" do
    should "not do anyhing" do
      @response.set_cookie("fanta", {:value => "wanna fanta", :domain => 'foo.bar'})
      assert_equal 'domain=foo.bar', domain_for_the_first_cookie_found
    end
  end

  context "if domain is not provided" do
    context "and value is a string" do
      should "set the domain to request.host but with subdomain support" do
        @test_request.expects(:host).returns('foo-bar.baz')
        @response.set_cookie("fanta", "wanna fanta")
        assert_equal 'domain=.foo-bar.baz', domain_for_the_first_cookie_found
      end
    end

    should "set the domain to request.host but with subdomain support" do
      @test_request.expects(:host).returns('foo-bar.baz')
      @response.set_cookie("fanta", {:value => "wanna fanta"})
      assert_equal 'domain=.foo-bar.baz', domain_for_the_first_cookie_found
    end

    should "remove subdomains" do
      @test_request.expects(:host).returns('thomas.f00.bar')
      @response.set_cookie("fanta", {:value => "wanna fanta"})
      assert_equal 'domain=.f00.bar', domain_for_the_first_cookie_found
    end

    should "do nothing for one word hosts" do
      @test_request.expects(:host).returns('localhost')
      @response.set_cookie("fanta", {:value => "wanna fanta"})
      assert_nil domain_for_the_first_cookie_found
    end
  end

  def domain_for_the_first_cookie_found
    @response["Set-Cookie"].scan(/domain=[a-z0-9-.]+/i).first
  end
end
