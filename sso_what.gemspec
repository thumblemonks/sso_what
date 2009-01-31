Gem::Specification.new do |s|
  s.name     = "sso_what"
  s.version  = "0.1.0"
  s.date     = "2009-01-30"
  s.summary  = "Rails extension to help with cookies in a system with sub-domains"
  s.email    = %w[gus@gusg.us gabriel.gironda@gmail.com]
  s.homepage = "http://github.com/thumblemonks/sso_what"
  s.description = "Rails extension to help with cookies in a system with sub-domains"
  s.authors  = %w[Justin\ Knowlden Gabriel\ Gironda]

  s.rubyforge_project = %q{sso_what}

  s.has_rdoc = true
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Load Model", "--main", "README.markdown"]
  s.extra_rdoc_files = ["README.markdown"]
  
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to?(:required_rubygems_version=)
  s.rubygems_version = "1.3.1"
  s.require_paths = ["lib"]

  # run git ls-files to get an updated list
  s.files = %w[
  ]
  
  s.test_files = %w[
  ]

  s.post_install_message = %q{Choosy ministries choose Thumble Monks}
end
