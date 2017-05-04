# rototiller - History
## Tags
* [LATEST - 28 Apr, 2017 (e51e3cdb)](#LATEST)
* [1.0.0 - 29 Nov, 2016 (bfa87d0a)](#1.0.0)
* [0.1.0 - 16 May, 2016 (ae2ceabe)](#0.1.0)

## Details
### <a name = "LATEST">LATEST - 28 Apr, 2017 (e51e3cdb)

* Merge pull request #75 from er0ck/acceptance/master/QA-2851-Pry_not_functional_during_Rototiller_task-fix-newline-issue (e51e3cdb)


```
Merge pull request #75 from er0ck/acceptance/master/QA-2851-Pry_not_functional_during_Rototiller_task-fix-newline-issue

(QA-2851) Fix missing pry prompts and extra newlines in stdout
```
* (QA-2851) Fix missing pry prompts and extra newlines in stdout (3db8f696)


```
(QA-2851) Fix missing pry prompts and extra newlines in stdout

* the previous fix to this ticket used `puts` to print the output stream.
puts tacks newlines on the end of each string. print does not.
* we also move the sleep to the end of the loop so it prints asap.
* `$stdout.sync` addition allows the pry prompt to show up as it syncs
the buffers before there is user interaction.
```
* Merge pull request #74 from er0ck/fix/stable/QA-2941-rototiller_rake12_task_args_object_is_no_longer_a_hash (6916b223)


```
Merge pull request #74 from er0ck/fix/stable/QA-2941-rototiller_rake12_task_args_object_is_no_longer_a_hash

(qa-2941) rototiller rake12 task args object is no longer a hash
```
* Merge pull request #73 from er0ck/fix/stable/QA-2851-Pry_not_functional_during_Rototiller_task (9f80dc04)


```
Merge pull request #73 from er0ck/fix/stable/QA-2851-Pry_not_functional_during_Rototiller_task

(qa-2851) pry not functional during rototiller task
```
* (maint) add empty.rb to .gitignore (48bb36a9)

* (QA-2941) fix acceptance for rake 12 (f5246728)

* (QA-2941) re-enable rake 12 (5f77f847)


```
(QA-2941) re-enable rake 12

* acceptance previously showed a bug we had against rake 12
* really rake 12 just clarified how to use arguments to tasks so they
aren't confused with hashes: https://github.com/ruby/rake/pull/171
```
* (maint) fix env_var_values acceptance which probably did not work before (1f34ebc2)


```
(maint) fix env_var_values acceptance which probably did not work before

* i'm not sure how this worked at all.  env_vars certainly update as in
the test, but the command was not printing as intended.  this might be
ruby version specific. We added a separate ticket to allow rototiller to
accept an array of strings for commands, other params (QA-2940).
```
* (QA-2851) fix spec tests for ruby < 2 against command.run changes (021167b5)


```
(QA-2851) fix spec tests for ruby < 2 against command.run changes

* Process.spawn changed between ruby 1.9 and 2. It no longer ENOENTs
upon a builtin like `exit` which it completely *can* find.
* we should probably handle this better later to make it consistent.
but since ruby 1.9.3 is EOL, we probably shouldn't care
```
* (maint) make beaker setup steps much faster (904b4fc0)

* (QA-2851) acceptance: allow arbitrary options to #execute_task_on (e17e1ba7)

* (QA-2851) Pry not functional during Rototiller task (80d1d588)


```
(QA-2851) Pry not functional during Rototiller task

- open3 libraries use Process.detach to relinquish control of
  subprocesses. This causes any debugging breakpoints or calls to
  interactive programs from rototiller to stall waiting on input we can
  never give it. This change uses Process.spawn to create a subprocess,
  inherit our stdin and pipe the results back to us for result.output
- some versions of gnu readline WILL corrupt the stdin to pry and the
  output, and byebug.  This appears to be an issue in readline 7. One
  solution is to use rb-readline in a gem bundle.  In somecases you can
  persuade rvm, for instance, to install editline, which does not seem
  to exhibit this bug. more info: https://github.com/pry/pry/issues/1275
- this change also includes a beaker system-test for this change
```
* (maint) acceptance: correct multiple require headers in test Rakefiles (eeff8ec2)

* (QA-2851) update unit tests to better test against command run changes (118363c7)


```
(QA-2851) update unit tests to better test against command run changes

- we can fix up some unit tests after the change to Process.spawn.  We
  also have better handling of ENOENT, update the tests for that.
```
* Merge pull request #72 from er0ck/fix/stable/maint-fix_acceptance_no_bundler_net-ssh_pin (2a5b8321)


```
Merge pull request #72 from er0ck/fix/stable/maint-fix_acceptance_no_bundler_net-ssh_pin

(maint) fix acceptance bundle
```
* (maint) re-add Gemfile.lock to .gitignore (974dc6c3)

* (maint) who knew gem install could be so complicated? (73a1bed8)


```
(maint) who knew gem install could be so complicated?

* force installs of rake to overwrite exes in osx
```
* (maint) acceptance: install implied rake version on sut (4a7b5749)

* (maint) rake version in Gemfile should not matter (15fe2573)

* (maint) acceptance: force rake gem install over system rake (829c32a3)

* (maint) argh. some rubygem versions don't have --no-document (bb863adc)

* (maint) fix acceptance bundle nokogiri ruby < 2 (a8dc77e4)

* (maint) fix acceptance bundle (a65a3d93)


```
(maint) fix acceptance bundle

* we can't commit a Gemfile.lock as we sweep one of our deps (rake)
  * unit test job uses bundle install not bundle update
* pin some deps here.  next major we'll require ruby > 2
```
* (maint) require < rake 12; we have a bug there (6204cccb)

* (maint) fix previous acceptance bundler on-sut removal (f947535f)


```
(maint) fix previous acceptance bundler on-sut removal

* a previous commit removed the bundle on the SUT
* forgot to commit the changes to the test to not specify bundle exec
```
* (maint) fix acceptance install for non-whole rake version strings (cba04b50)


```
(maint) fix acceptance install for non-whole rake version strings

* previous change did not account for when x.y.z rake version strings were not specified.
```
* (maint) remove bundler/gem_tasks from Rakefile (b160a347)


```
(maint) remove bundler/gem_tasks from Rakefile

* i guess we never got around to adding Gem building tasks
```
* Merge pull request #71 from er0ck/fix/stable/QA-2887-Rototiller_should_not_depend_on_Rake_11_x_for_realz (b5f1f6fa)


```
Merge pull request #71 from er0ck/fix/stable/QA-2887-Rototiller_should_not_depend_on_Rake_11_x_for_realz

(qa-2887) rototiller should not depend on rake 11 x for realz
```
* (QA-2887) Rototiller should not depend on Rake 11 x for realz (68c3035c)


```
(QA-2887) Rototiller should not depend on Rake 11 x for realz

* previous commit totally forgot to take into account the gemspec file
* this commit also fixes our acceptance install of rototiller
```
* (maint) pin nokogiri for acceptance tests against older ruby (ea634dbb)

* Merge pull request #69 from er0ck/fix/stable/QA-2887-Rototiller_should_not_depend_on_Rake_11_x (82995273)


```
Merge pull request #69 from er0ck/fix/stable/QA-2887-Rototiller_should_not_depend_on_Rake_11_x

(QA-2887) Rototiller should not depend on Rake 11
```
* (QA-2887) Rototiller should not depend on Rake 11 (f2169c6c)


```
(QA-2887) Rototiller should not depend on Rake 11

* previously the gemfile would require ~> 11.0 if no env was set
* this causes problems with beaker who requires ~>10.0
* set to anything greater/equal than 0.9.0 unless the env is used
```
* Merge pull request #68 from er0ck/maint/stable/fixup_doc_problems (09d5d608)


```
Merge pull request #68 from er0ck/maint/stable/fixup_doc_problems

(maint) fixup doc problems
```
* (maint) bump stable version to probable next Z (1a8809fe)

* (maint) fixup doc problems (4c87b28f)


```
(maint) fixup doc problems

* old docs from pre-1.0 left hanging around, now removed
* remove spurious process for creating yard server
  * point to rubydoc.org instead
* fix reference doc table in GH markdown
* fix reference doc TOC links
```
### <a name = "1.0.0">1.0.0 - 29 Nov, 2016 (bfa87d0a)

* (HISTORY) update rototiller history for gem release 1.0.0 (bfa87d0a)

* (GEM) update rototiller version to 1.0.0 (11c841a7)

* Merge pull request #67 from er0ck/feature/master/QA-2539-rototiller_messaging (22276a1d)


```
Merge pull request #67 from er0ck/feature/master/QA-2539-rototiller_messaging

(QA-2539) rototiller messaging
```
* (QA-2539) fix acceptance due to upstream changes (c8e80777)


```
(QA-2539) fix acceptance due to upstream changes

* add acceptance test for param messaging
```
* (maint) move to_str from switch_collection to param_collection (7adfb8b0)


```
(maint) move to_str from switch_collection to param_collection

* it's used in all types of params (overridden in env_var)
* was confusing in switch_collection
* this allows option_collection to just inherit param_collection
  * fewer layers of inheritance
```
* (QA-2539) update yard docs for new/refined param methods (f35067b3)

* (maint) fixup typos and indenting in acceptance (8db976df)

* (QA-2539) human readable docs (a17c5106)


```
(QA-2539) human readable docs

* mostly fixup some stop related docs
* messaging doesn't require much documentation
* update class diagram
```
* (QA-2539) refine spec tests around messaging (6d7b59f0)

* (QA-2539) rototiller messaging (dd5aff79)


```
(QA-2539) rototiller messaging

* refine existing messaging around environment variables for each of the
  4 cases
  * each of the params knows what of its params may have messages and
    asks them for them
```
* Merge pull request #57 from er0ck/maint/master/harden_gemfile-restrict_ruby (f833782a)


```
Merge pull request #57 from er0ck/maint/master/harden_gemfile-restrict_ruby

(maint) harden gemfile, restrict ruby
```
* Merge pull request #66 from zreichert/feature/master/QA-2690_stop_on_any_nested_env_var (e7e59e17)


```
Merge pull request #66 from zreichert/feature/master/QA-2690_stop_on_any_nested_env_var

(QA-2690) stop on any nested env var
```
* Merge pull request #65 from james-stocks/QA-2472 (941acb20)


```
Merge pull request #65 from james-stocks/QA-2472

(QA-2472) Acceptance test that asserts env vars during task execution
```
* (QA-2690) Stopping on any nested env_var (cd317ff3)

* (QA-2690) Stopping on any nested env_var (2d2375da)

* (QA-2539) clarify reference doc on environment variable cases and messaging (03ca216c)


```
(QA-2539) clarify reference doc on environment variable cases and messaging

* also fix TOC
* add docs on various param levels missing from Command
```
* (maint) fix preserve hosts env var in Rakefile (69ae9307)

* (maint) remove beta, api changes, warnings from README (f692bdcb)

* (maint) allow installing current version of rototiller in Gemfile (56a36ce2)

* (QA-2472) Acceptance test that asserts env vars during task execution (17820ac2)


```
(QA-2472) Acceptance test that asserts env vars during task execution

Adds an acceptance test that asserts the actual values of environment variables during task execution.
```
* Merge pull request #64 from er0ck/docs/master/QA-2686-Spike_Investigate_Commands_Returning_Non-zero_Exit_Codes_as_Success (bea80c97)


```
Merge pull request #64 from er0ck/docs/master/QA-2686-Spike_Investigate_Commands_Returning_Non-zero_Exit_Codes_as_Success

(QA-2686) Clarify Commands Returning Non-zero Exit Codes in docs
```
* (QA-2686) Clarify Commands Returning Non-zero Exit Codes in docs (3eb02fc6)


```
(QA-2686) Clarify Commands Returning Non-zero Exit Codes in docs

* also fix MAINTAINERS email list
```
* Merge pull request #61 from er0ck/feature/master/QA-2634-rototiller_command_add_argument (831bd9ea)


```
Merge pull request #61 from er0ck/feature/master/QA-2634-rototiller_command_add_argument

(QA-2634) rototiller command add_argument
```
* (maint) fix dog-fooding issue in our Rakefile (6509988b)


```
(maint) fix dog-fooding issue in our Rakefile

* previously we were loading all of rototiller into the LOAD_PATH in the
gemspec file just so we could enable unit testing. This causes issues
when using the Rakefile, which loads the same code when using a
breakpoint anywhere in the code or tests. The debugger would never
yield to the prompt.
  * this also means we have to remove the call to the gemspec in the
    Gemfile. bundler doesn't allow the inclusion of the same gem twice.
* we can't have changes to our code breaking our own rakefile, so we
* need to dogfood the stable version of rototiller.
* we also remove the spec files from the gem, and add in missing files
```
* Merge pull request #63 from theshanx/patch-1 (7e27da04)


```
Merge pull request #63 from theshanx/patch-1

(maint) Add internal_list key to MAINTAINERS
```
* Merge pull request #62 from zreichert/maint/master/hash_handling_spec_test (98aece37)


```
Merge pull request #62 from zreichert/maint/master/hash_handling_spec_test

(MAINT) add hash_handling_spec
```
* (maint) Add internal_list key to MAINTAINERS (a7e5debd)


```
(maint) Add internal_list key to MAINTAINERS

This change adds a reference to the Google group the maintainers are associated with.
```
* (MAINT) add hash_handling_spec (5e153648)

* (QA-2634) command add_argument docs (4edf04c7)


```
(QA-2634) command add_argument docs

* also fixup add_option docs
```
* (QA-2634) update class diagram and Rakefile docs:class_graph (6870f6d2)

* Merge pull request #58 from zreichert/feature/master/QA-2541_add_option_for_real_this_time (659d377e)


```
Merge pull request #58 from zreichert/feature/master/QA-2541_add_option_for_real_this_time

(QA-2541) add_option on command
```
* Merge pull request #59 from er0ck/maint/master/fix_osx_gem_install (56c50b55)


```
Merge pull request #59 from er0ck/maint/master/fix_osx_gem_install

(maint) fix osx gem install
```
* (QA-2634) rototiller command add_argument acceptance tests (7c5c55b1)

* (QA-2634) rototiller command: add_argument spec tests (9fdb86ba)

* (QA-2634) fixup some comments and spurious code in command Option (0f7aa4f0)

* (QA-2634) rototiller command: add_argument (6cb2bda1)

* (maint) update tests to use bundle exec (cba73761)


```
(maint) update tests to use bundle exec

* ugh... we can't just cram the bundle bin in the PATH, we still get
rake version conflicts
```
* (maint) fix rake install on suts (18abed49)


```
(maint) fix rake install on suts

* wow.  we need bundler
  * when back-revving from 'system' rake, we need bundler or all hell breaks loose.
* we should probably put the bundle path in the... path so we don't have
to use bundle exec
* installing local gems from files is super painful.  WHY?
```
* (maint) update qa email address in gemspec (7b896185)

* (maint) fix osx gem install (a42fdcec)

* (QA-2541) docs and tests for add_option (549defa6)

* (QA-2541) add add_option to command (2f33d237)

* Merge pull request #56 from er0ck/improve/master/QA-2542-rototiller__add_switch (c6aeb8d7)


```
Merge pull request #56 from er0ck/improve/master/QA-2542-rototiller__add_switch

(qa-2542) Command `#add_switch`
```
* (maint) restrict ruby to >= 1.9.3 in gemspec (108de594)

* (maint) harden gemfile (310f2deb)


```
(maint) harden gemfile

* pin more deps based upon ruby version
```
* (maint) set non-implemented acceptance tests to pending (eaa7107d)

* (maint) fix env_var and command-env_var tests (92ea2403)


```
(maint) fix env_var and command-env_var tests

* these tests snuck by with with false-positives
  * changes in `#execute_task_on` caught them
```
* (QA-2542) add Command `#add_switch` markdown/human docs (40ab5543)

* (QA-2542) acceptance: command add_switch (897e2cad)


```
(QA-2542) acceptance: command add_switch

* add acceptance tests for command's `#add_switch`
* FIXME: changes to acceptance lib broke other tests
```
* (maint) add docs:check task to view undocumented units (a2fa74fe)

* (QA-2542) add yard docs for Command's `#add_switch` (7e2d8bcb)


```
(QA-2542) add yard docs for Command's `#add_switch`

* also add a bit more docs (`#param_collection`), to get our numbers up
```
* (maint) fix documentation and Rake tasks (7ac0be45)


```
(maint) fix documentation and Rake tasks

* add a link to CONTRIBUTING.md from README.md
* add architecture diagram, class_graph to CONTRIBUTING
* fix class_graph docs rake task
* remove class diagram from .gitignore
* use default yard dir, because: why not?
```
* (maint) fix acceptance generate_host_config LAYOUT/TARGET (be522466)

* (QA-2542) spec tests for command add_switch (2ed18309)


```
(QA-2542) spec tests for command add_switch

* FIXME: this is almost exactly spec tests for add_env in some cases
  * we need to dry this thing out, but for now it's easy to follow
```
* (QA-2542) command add_switch (77723acc)

* Merge pull request #54 from er0ck/maint/master/acceptance_add_platform_axis (e6de71e4)


```
Merge pull request #54 from er0ck/maint/master/acceptance_add_platform_axis

(maint) acceptance: add platform axis support
```
* Merge pull request #55 from er0ck/improve/master/QA-2637-rototiller__command_add_env (1f6e1b75)


```
Merge pull request #55 from er0ck/improve/master/QA-2637-rototiller__command_add_env

(QA-2637) command: #add env
```
* (QA-2637) Update README with command's #add_env functionality (df81cc20)


```
(QA-2637) Update README with command's #add_env functionality

* also commit an example Rakefile which mirrors the README's
 functionality
```
* (QA-2637) Add yard docs on new methods, increase other yard coverage (d58c3abe)


```
(QA-2637) Add yard docs on new methods, increase other yard coverage

This commit also unifies some of the private method style, and documents
them as private.
We change the Class documentation to be based at that level, rather than
at the attribute level.
```
* (QA-2637) acceptance for command #add_env (70d9cbda)


```
(QA-2637) acceptance for command #add_env

* fix existing acceptance, remove override_env
* fix command_arguments acceptance which for somereason still uses
command override_env.  this should be removed from that test, later
```
* (QA-2637) add spec tests for command add env (62560fcb)


```
(QA-2637) add spec tests for command add env

* also add spec tests for changes to block_handling, env_collection
* added tests to rototiller_task because they can more easily
  integrate other classes. This is bad, they should be moved to some
  integration test-block.
```
* (QA-2637) command #add_env (37b396d4)


```
(QA-2637) command #add_env

* add #add_env to command
* it will overwrite command name with its value
* FIXME: we mainly duplicate add_env here from rototiller_task, it can
  be put in a module
* add #to_str for EnvVar so it can be printed and find its value
* add #last to env_collection so one can easily find the last known
value of a collection of EnvVars.
* block_handling needed empty methods defined for nested blocks and
hashes. When a Command is created and has a nested add_env, for
instance, the add_env must be both a setter and a method (getter), even
though it is not actually called.
* ensure we return the EnvVar or Command when using #add_env or
 #add_command
* EnvVar (and other params) need their attribute names to match their
allowed attributes because we now must yield using EnvVar objects, so
the blocks populate the actual EnvVar
```
* (maint) acceptance: add platform axis support (fbc1d5c6)

* Merge pull request #52 from zreichert/maint/master/add_maintainers_file (bc83e244)


```
Merge pull request #52 from zreichert/maint/master/add_maintainers_file

(MAINT) add MAINTAINERS file
```
* (MAINT) add MAINTAINERS file (5588f79a)

* Merge pull request #51 from er0ck/improve/master/QA-2549-add_multiple_command_handling (c05335ae)


```
Merge pull request #51 from er0ck/improve/master/QA-2549-add_multiple_command_handling

(QA-2549) add multiple command handling
```
* (QA-2549) update README with multiple command docs (1e75ef10)

* (QA-2549) add multiple command handling acceptance test (9947c940)

* Merge remote-tracking branch 'upstream/stable' (e502f54f)

* (maint) upgrade rspec to prevent last_comment deprecation warnings/errors (4ca6f049)

* Merge remote-tracking branch 'upstream/stable' (8a4731fe)


```
Merge remote-tracking branch 'upstream/stable'

Conflicts:
	acceptance/pre-suite/01_install_rototiller.rb
```
* (maint) fix acceptance pre-suite require (3da05d0b)


```
(maint) fix acceptance pre-suite require

require is not needed, and indeed breaks in master
[skip ci]
```
* Merge remote-tracking branch 'upstream/stable' (0a3e3d4a)

* (QA-2549) temporarily remove add_flag from our Rakefile (140129a7)

* (QA-2549) fix command run and results (d3d04aee)


```
(QA-2549) fix command run and results

previous attempts at command#run did not print the command's output.
This change streams it as it's running, and captures output, pid, and
exit_code.
* we also fix the spec tests
```
* (maint) skip tests we've broken so far... (f9586787)


```
(maint) skip tests we've broken so far...

This commit can be reverted later when we've fixed options and switches,
or we can (and probably will have to) re-write the tests anyway.
```
* (QA-2549) remove env_var requirement from param_collection (beb97ff8)


```
(QA-2549) remove env_var requirement from param_collection

* the tests used to require env_var in param_collection
  * this change mocks the return of allowed_class in param_collection,
 so we can test with env_vars and not include them in production code.
* add a test for adding incorrect params to a collection
```
* (QA-2549) fix spec tests for ruby 1.9.3 (9ca9ee02)

* (QA-2549) fix set_env and tests (59e8dbf9)


```
(QA-2549) fix set_env and tests

* restore v0.1.0 set_env behavior of :set_env
  * enable in block/hash mode for add_env
* set it to true in its use in Rakefile, otherwise we get non-helpful
errors from rspec :-\
* rename `:message` to `:user_message` in env_var to avoid collisions with
`#message` and `#message=`
  * remove `:message` accessor as we have dedicated methods for this
* re-enable both types of init_method for RototillerTask tests
```
* Merge pull request #50 from er0ck/tests/stable/QA-2517-rototiller__test_against_rake_11 (d014e1e0)


```
Merge pull request #50 from er0ck/tests/stable/QA-2517-rototiller__test_against_rake_11

(QA-2517) test against rake 11
```
* (QA-2549) add simple boilerplate unit tests for new params, collections (a12272cc)


```
(QA-2549) add simple boilerplate unit tests for new params, collections

* CommandCollection
* RototillerParam
```
* (QA-2549) add/improve Command param's unit testing (e38a143e)


```
(QA-2549) add/improve Command param's unit testing

changes to Command found when adding tests:
* result should not be directly set-able
  * same with the override_envs, which will change form anyway
* argument should be set-able, for now, why not (will be a collection later)
```
* (QA-2549) refactor collection children: move push/check_classes to parent (fd782ed6)


```
(QA-2549) refactor collection children: move push/check_classes to parent

* this requires EnvVar use in param_collection because of the way the
tests are written. we should fix this later
```
* (QA-2549) fix/remove existing spec tests (986c2f68)


```
(QA-2549) fix/remove existing spec tests

* also fix found bug in env_var after recent commits
```
* (maint) add yard_docs tmpdir to .gitignore (f0f06da5)

* (maint) add/fixup yard docs for classes and methods (b68be054)


```
(maint) add/fixup yard docs for classes and methods

* add docs for various methods
* yard doesn't like hash rockets in comments :-(
```
* (maint) add yard doc tasks (4aa85b4c)

* (QA-2549) add yardoc for #pull_params_from_block (9fc995f1)

* (QA-2549) add block_handling spec tests (0c1de3f8)

* (maint) refactor directory structure; clean out utilities (6f6f3999)


```
(maint) refactor directory structure; clean out utilities

 * move some classes to different modules as well, so we don't have as
     many includes in classes that are used in common combinations
     (`Rototiller::Task`)
 * this runs simple command tasks, but will fail almost all the tests
 * subsequent commits will refactor the API and its tests
```
* (QA-2549) add multiple command handling (945560d2)


```
(QA-2549) add multiple command handling

* move pull_params_from_block to `BlockHandling` module
* create `CommandCollection` class
* skeleton `RototillerParam` class for later use as base class
* add `#each` to CommandCollection so we can loop through them
* update command and env_var types to both use block handling the same way
* add commandCollection to rototiller_task and loop through the commands
* create a results struct for command to populate using popen3
* return an array of results (one member for each command)
```
* (QA-2517) setup for testing against arbitrary rake versions (7915c1e7)

* (maint) pin activesupport gem for ruby 1.9.3: (61b393d5)

* Merge pull request #49 from er0ck/acceptance/master/QA-2478-refactor_rototiller_acceptance_repeated_code (afc29d42)


```
Merge pull request #49 from er0ck/acceptance/master/QA-2478-refactor_rototiller_acceptance_repeated_code

(qa-2478) refactor rototiller acceptance repeated code
```
* Merge pull request #43 from er0ck/fix/master/maint-use_correct_library_when_building_gem (6947e4fa)


```
Merge pull request #43 from er0ck/fix/master/maint-use_correct_library_when_building_gem

(maint) use correct library when building gem
```
* (maint) rename some uses of flag to option in tests (fdcf31ed)


```
(maint) rename some uses of flag to option in tests

[skip ci]
```
* (maint) Rakefile: remove hyphens from env vars, add log-level (a4321cbf)


```
(maint) Rakefile: remove hyphens from env vars, add log-level

[skip ci]
```
* (QA-2478) abstract the rakefile segment generation (cfa5309f)


```
(QA-2478) abstract the rakefile segment generation

The rakefile segment generation method was very similar across tests.
Move it to a library. It could probably use some clarity and more
fanciness, but this works for now and should allow us to more easily
create tests for api v2.

[skip ci]
```
* (QA-2478) create unique Rakefile per test (34882416)


```
(QA-2478) create unique Rakefile per test

Previously we were just putting a Rakefile in /root.
This is great for using the default rake behavior of finding Rakefiles.
but is difficult to debug when tests fail.  Now we place a
unique-per-run Rakefile in /tmp and specify that file for rake to run.

[skip ci]
```
* Merge pull request #46 from er0ck/task/master/maint-create_CONTRIBUTING_doc (8ce00f67)


```
Merge pull request #46 from er0ck/task/master/maint-create_CONTRIBUTING_doc

(maint) create CONTRIBUTING doc
```
* (QA-2478) acceptance: abstract remove_reserved_keys out of tests (58ab5d1e)


```
(QA-2478) acceptance: abstract remove_reserved_keys out of tests

[skip ci]
```
* (QA-2478) acceptance: abstract rake task execution out of tests (1e8fe321)


```
(QA-2478) acceptance: abstract rake task execution out of tests

[skip ci]
```
* (maint) rename some "flag" usage to "switch" in tests (d9aa49fe)


```
(maint) rename some "flag" usage to "switch" in tests

[skip ci]
```
* (QA-2478) abstract rakefile headers, remove from tests (e65af4b7)


```
(QA-2478) abstract rakefile headers, remove from tests

the header for the Rakefiles used in tests were repeated across all
tests. Here we abstract this into a module

[skip ci]
```
* (QA-2478) remove step blocks in modules (4942c5e8)


```
(QA-2478) remove step blocks in modules

steps with blocks in modules causes beaker to not un-indent the logging
properly, remove these.  :-(

[skip ci]
```
* Merge pull request #48 from er0ck/improve/master/QA-2521-Research_V2_API_for_Rototiller (eae118fc)


```
Merge pull request #48 from er0ck/improve/master/QA-2521-Research_V2_API_for_Rototiller

(QA-2521) define all permutations for v2 API
```
* (QA-2521) define all permutations for v2 API (7f43b984)


```
(QA-2521) define all permutations for v2 API

[skip ci]
```
* Merge pull request #47 from er0ck/fix/master/QA-2477-rototiller__add_flag_with_no_command_set_should_error (f3caf08b)


```
Merge pull request #47 from er0ck/fix/master/QA-2477-rototiller__add_flag_with_no_command_set_should_error

(QA-2477) add flag with no command set should error
```
* (QA-2477) add flag with no command set should error (ad2577fc)


```
(QA-2477) add flag with no command set should error

A simple fix that should never happen, unless the user forcibly removes
the command (that currently has a default).
```
* (maint) create CONTRIBUTING doc (143416ef)


```
(maint) create CONTRIBUTING doc

[skip ci]
```
* (maint) use correct library when building gem (83872098)


```
(maint) use correct library when building gem

Before this change, acceptance would use any installed rototiller gem
for its version string when building the gem for acceptance. This would
cause issues if not using bundler, or had some old version of the gem.
And we have this info right relatively here, let's use it.
```
### <a name = "0.1.0">0.1.0 - 16 May, 2016 (ae2ceabe)

* Initial release.
