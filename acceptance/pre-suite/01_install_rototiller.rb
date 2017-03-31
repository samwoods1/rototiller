test_name 'install rototiller' do
  sut = find_only_one('agent')

  `gem build rototiller.gemspec`
  gem_name = Dir.glob('rototiller-*.gem').first
  teardown do
    `rm #{gem_name}`
  end
  scp_to(sut, gem_name, gem_name)

  if ENV['RAKE_VER']
    on(sut, "gem install rake --no-document --version #{ENV['RAKE_VER']}")
  else
    on(sut, "gem install --no-document rake")
  end
  on(sut, "gem install --no-document ./#{gem_name}")
end
