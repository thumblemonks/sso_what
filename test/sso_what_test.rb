require 'test/unit'
require 'rubygems'
require 'shoulda'
require 'mocha'
require 'action_controller'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'init'))

class SsoWhatTest < Test::Unit::TestCase

  context "with session_domain option set to :base_host" do
    setup do
      cgi, opts = CGI.new, {:session_domain => :base_host}
      @request  = ActionController::CgiRequest.new(cgi, opts)
    end

    should "nil the cookie domain when host consists of one part" do
      @request.expects(:host).returns('foohost')
      assert_nil @request.default_session_domain
    end
    
    should "wildcard the cookie domain to the entire domain when host consists of two parts" do
      @request.expects(:host).returns('foohost.bar')
      assert_equal 'foohost.bar', @request.default_session_domain
    end
    
    should "wildcard the cookie domain to the base domain when host consists of three parts" do
      @request.expects(:host).returns('gah.foohost.bar')
      assert_equal 'foohost.bar', @request.default_session_domain
    end
    
    should "wildcard the cookie domain to the base domain when host consists of four parts" do
      @request.expects(:host).returns('publisher.gah.foohost.bar')
      assert_equal 'foohost.bar', @request.default_session_domain
    end
    
    should "have session_options_with_string_keys insert the expected session domain into the hash" do
      @request.expects(:host).returns('weird.biscotti.eating.habits')
      generated_opts = @request.send(:session_options_with_string_keys)
      assert_equal 'eating.habits', generated_opts['session_domain']
    end
    
  end

  context "with session_domain option set to nil" do
    setup do
      cgi, opts = CGI.new, {:session_domain => nil}
      @request  = ActionController::CgiRequest.new(cgi, opts)
    end
    
    should "return nil for default session domain" do
      @request.stubs(:host).returns('gah.foohost.bar')
      assert_nil @request.default_session_domain      
    end
    
  end
  
  context "with session_domain option set to a custom domain" do
    setup do
      cgi, opts = CGI.new, {:session_domain => 'biscotti.com'}
      @request  = ActionController::CgiRequest.new(cgi, opts)
    end
    
    should "return the manually set session domain" do
      @request.stubs(:host).returns('gah.foohost.bar')
      assert_equal 'biscotti.com', @request.default_session_domain      
    end
    
  end
  
    
end
