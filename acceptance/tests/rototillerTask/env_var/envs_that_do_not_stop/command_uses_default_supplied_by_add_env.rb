require 'beaker/hosts'
require 'rakefile_tools'
require 'test_utilities'

test_name 'A command should use the default when supplied one through add_env' do
  extend Beaker::Hosts
  extend RakefileTools
  extend TestUtilities

  # an env with a default should not stop the task
  validation_string = 'Journey'
  env_with_default = {:name => 'DONTSTOP', :message => 'Dont STOP BELIEVING', :default => "echo #{validation_string}"}
  sut.clear_env_var(env_with_default[:name])

  @block_syntax = 'block_syntax'

  block_body = {
    :add_command => {
      :add_env => env_with_default,
    }
  }

  rakefile_contents = <<-EOS
#{rototiller_rakefile_header}
Rototiller::Task::RototillerTask.define_task :#{@block_syntax} do |x|
  #{RototillerBodyBuilder.new(block_body)}
end
  EOS
  rakefile_path = create_rakefile_on(sut, rakefile_contents)

  #add env to command
  step 'Run rake task defined in block syntax, ENV not set' do
    execute_task_on(sut, @block_syntax, rakefile_path) do |result|

      assert_match(/#{validation_string}/, result.stdout, "The ENV was not observed at runtime")

      rototiller_output_regex = /INFO: no system environment-variable.*using default.*#{env_with_default[:name]}.*#{env_with_default[:default]}.*#{env_with_default[:message]}/
      assert_msg = 'The expected output was not observed'
      assert_match(rototiller_output_regex, result.stdout, assert_msg)
      assert(result.exit_code == 0, 'The expected error message was not observed')
    end
  end
end
