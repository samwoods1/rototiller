require 'rspec/core/rake_task'
require 'fileutils'
require 'rototiller'

task :default do
  sh %{rake -T}
end

# temporary backwards compat
task :test => :'test:unit'
task :acceptance => :'test:acceptance'

namespace :test do

  desc "Run unit tests"
  RSpec::Core::RakeTask.new('unit') do |t|
    t.rspec_opts = ['--color']
    t.pattern = ENV['SPEC_PATTERN']
  end

  task :unit => [:check_unit]

  default_rake_ver = '11.0'

  desc "" # empty description so it doesn't show up in rake -T
  rototiller_task :check_unit do |t|
    t.add_env({:name => 'SPEC_PATTERN', :default => 'spec/', :message => 'The pattern RSpec will use to find tests'})
    t.add_env({:name => 'RAKE_VER',     :default => default_rake_ver,  :message => 'The rake version to use when running unit tests'})
  end

  desc ""
  #FIXME: this is probably a build task, given that it has an output file
  rototiller_task :generate_host_config do |t|
    t.add_command({:name => 'rm -f acceptance/hosts.cfg'})
    t.add_command do |bhg_command|
      bhg_command.name = "beaker-hostgenerator"
      bhg_command.add_argument do |argument|
        # ugh, this is terrible, but it's the only way in current rototiller
        argument.name = ENV['BEAKER_ABS'] ? ' --hypervisor=abs' : ''
        argument.message = 'Use hypervisor abs option for bhg'
      end
      bhg_command.add_argument do |arg|
        arg.name = 'centos7-64'
        arg.add_env({:name => 'LAYOUT', :message => 'The beaker-hostgenerator pattern (deprecated)'})
        arg.add_env({:name => 'TEST_TARGET', :message => 'The beaker-hostgenerator pattern (used even if LAYOUT has a value)'})
      end
      bhg_command.add_argument({:name => '> acceptance/hosts.cfg'})
    end
  end

  desc "Run acceptance tests"
  rototiller_task :acceptance => [:generate_host_config] do |t|
    t.add_env({:name => 'BEAKER_ABS', :default => '',
               :message => 'if set, use ABS hypervisor',
               })
    t.add_env({:name => 'RAKE_VER', :default => default_rake_ver,
               :message => 'The rake version to use IN unit and acceptance tests',
               })

    t.add_command do |command|
      command.name = "beaker --debug --no-ntp --repo-proxy --no-validate --keyfile #{ENV['HOME']}/.ssh/id_rsa-acceptance --load-path acceptance/lib --pre-suite acceptance/pre-suite"
      command.add_env({:name => 'BEAKER_EXECUTABLE'})

      command.add_option do |option|
        option.name = '--hosts'
        option.message = 'The hosts file that Beaker will use'
        option.add_argument do |arg|
          arg.name = 'acceptance/hosts.cfg'
          arg.add_env({:name => 'BEAKER_HOSTS'})
        end
      end
      command.add_option do |option|
        option.name = '--preserve-hosts'
        option.message = 'The beaker setting to preserve a provisioned host'
        option.add_argument do |arg|
          arg.name = 'never'
          arg.add_env({:name => 'BEAKER_PRESERVE_HOSTS'})
        end
      end
      command.add_option do |option|
        option.name = '--tests'
        option.message = 'The path to the tests for beaker to run'
        option.add_argument do |arg|
          arg.name = 'acceptance/tests'
          arg.add_env({:name => 'BEAKER_TESTS'})
        end
      end

    end

  end

end

namespace :docs do
  YARD_DIR = 'doc'
  desc 'Clean/remove the generated documentation cache'
  task :clean do
    original_dir = Dir.pwd
    Dir.chdir( File.expand_path(File.dirname(__FILE__)) )
    sh "rm -rf #{YARD_DIR}"
    Dir.chdir( original_dir )
  end

  desc 'Generate static documentation'
  #FIXME: this is probably a build task, given that it has output files
  task :gen do
    original_dir = Dir.pwd
    Dir.chdir( File.expand_path(File.dirname(__FILE__)) )
    output = `yard doc`
    puts output
    if output =~ /\[warn\]|\[error\]/
      begin # prevent pointless stack on purposeful fail
        fail "Errors/Warnings during yard documentation generation"
      rescue Exception => e
        puts 'Yardoc generation failed: ' + e.message
        exit 1
      end
    end
    Dir.chdir( original_dir )
  end

  desc 'Check amount of documentation'
  task :check do
    original_dir = Dir.pwd
    Dir.chdir( File.expand_path(File.dirname(__FILE__)) )
    output = `yard stats --list-undoc`
    puts output
    if output =~ /\[warn\]|\[error\]/
      begin # prevent pointless stack on purposeful fail
        fail "Errors/Warnings during yard documentation generation"
      rescue Exception => e
        puts 'Yardoc generation failed: ' + e.message
        exit 1
      end
    end
    Dir.chdir( original_dir )
  end

  desc 'Generate static class/module/method graph. Calls docs:gen'
  task :class_graph => [:gen] do
    DOCS_DIR = 'docs'
    original_dir = Dir.pwd
    Dir.chdir( File.expand_path(File.dirname(__FILE__)) )
    graph_processor = 'dot'
    if exe_exists?(graph_processor)
      FileUtils.mkdir_p(DOCS_DIR)
      if system("yard graph --full | #{graph_processor} -Tpng -o #{DOCS_DIR}/rototiller_class_graph.png")
        puts "we made you a class diagram: #{DOCS_DIR}/rototiller_class_graph.png"
      end
    else
      puts 'ERROR: you don\'t have dot/graphviz; punting'
    end
    Dir.chdir( original_dir )
  end
end

# Cross-platform exe_exists?
def exe_exists?(name)
  exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
  ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
    exts.each { |ext|
      exe = File.join(path, "#{name}#{ext}")
      return true if File.executable?(exe) && !File.directory?(exe)
    }
  end
  return false
end
