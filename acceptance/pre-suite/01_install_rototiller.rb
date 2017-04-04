test_name 'install rototiller' do
  sut = find_only_one('agent')

  `gem build rototiller.gemspec`
  gem_name = Dir.glob('rototiller-*.gem').first
  teardown do
    `rm #{gem_name}`
  end
  scp_to(sut, gem_name, gem_name)

  if ENV['RAKE_VER']
    rake_version = Gem::Version.new(ENV['RAKE_VER']).approximate_recommendation
    on(sut, "gem install rake --version '#{rake_version}'")
  else
    on(sut, "gem install rake")
  end

  on(sut, "gem install ./#{gem_name}")
end
