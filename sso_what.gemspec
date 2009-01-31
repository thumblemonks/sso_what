Gem::Specification.new do |s|
  s.name     = "sso_what"
  s.version  = "0.1.1"
  s.date     = "2009-01-30"
  s.summary  = "Rails extension to help with cookies in a system with sub-domains"
  s.email    = %w[gus@gusg.us gabriel.gironda@gmail.com]
  s.homepage = "http://github.com/thumblemonks/sso_what"
  s.description = "Rails extension to help with cookies in a system with sub-domains"
  s.authors  = %w[Justin\ Knowlden Gabriel\ Gironda]

  s.rubyforge_project = %q{sso_what}

  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "SSO What", "--main", "README.markdown"]
  s.extra_rdoc_files = %w[README.markdown MIT-LICENSE]
  
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to?(:required_rubygems_version=)
  s.rubygems_version = "1.3.1"
  s.require_paths = ["lib"]

  # run git ls-files to get an updated list
  s.files = %w[
    MIT-LICENSE
    README.markdown
    Rakefile
    lib/centro/base_host.rb
    lib/sso_what.rb
    lib/thumblemonks/subdomain_cookie_jar.rb
    sso_what.gemspec
  ]
  
  s.test_files = %w[
    test/base_host_test.rb
    test/subdomain_cookie_jar_test.rb
    test/test_helper.rb
  ]

  s.post_install_message = %q{Choosy ministries choose Thumble Monks}
end
