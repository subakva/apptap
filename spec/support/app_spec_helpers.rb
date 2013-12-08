module AppSpecHelpers extend self
  def app_root_path
    Pathname.new('./tmp/app')
  end

  def app_config_path
    app_root_path + 'config'
  end

  def app_formulae_path
    app_config_path + 'formulae'
  end

  def app_config_yml_path
    app_config_path + 'apptap.yml'
  end

  def app_procfile_path
    app_root_path + 'Procfile.dev'
  end

  def app_gitignore_path
    app_root_path + '.gitignore'
  end

  def brew_install_path
    app_root_path + '.brew'
  end

  def brew_apptap_path
    brew_install_path + 'Library' + 'Contributions' + 'cmd' + 'brew-apptap.rb'
  end

  def brew_local_tap_path
    brew_install_path + 'Library' + 'Taps' + 'local-formulae'
  end

  def brew_linked_formula_path
    brew_install_path + 'Library' + 'Formula' + 'make_awesome.rb'
  end

  def formula_fixture_path
    File.expand_path('../../../spec/fixtures/make_awesome.rb', __FILE__)
  end

  def add_local_formula
    FileUtils.cp(formula_fixture_path, app_formulae_path, :verbose => spec_debug?)
  end

  def remove_local_formula
    FileUtils.rm_rf(app_formulae_path + 'make_awesome.rb', :verbose => spec_debug?)
  end

  def spec_debug?
    %w{1 yes true y}.include?(ENV['DEBUG'].to_s.downcase)
  end

  def call_apptap(command)
    FileUtils.chdir(app_root_path) do
      if spec_debug?
        system "bundle exec apptap #{command}"
      else
        `bundle exec apptap #{command}`
      end
    end
  end
end

RSpec.configure do |config|
  config.include AppSpecHelpers

  # Initialize everything once before the suite for speedier tests. Tests should be able to
  # assume that init has been run and there are no linked formulae or services installed.
  config.before(:suite) do
    FileUtils.mkdir_p(AppSpecHelpers.app_root_path)
    FileUtils.cp('./spec/fixtures/Gemfile', File.join(AppSpecHelpers.app_root_path))
    FileUtils.touch(AppSpecHelpers.app_gitignore_path)
    FileUtils.chdir(AppSpecHelpers.app_root_path) do
      `bundle`
    end
    AppSpecHelpers.call_apptap('init')
  end

  # Delete everything but homebrew (need a task to reset that, too)
  config.after(:suite) do
    [
      AppSpecHelpers.brew_local_tap_path,
      AppSpecHelpers.brew_linked_formula_path,
      AppSpecHelpers.brew_apptap_path,
      AppSpecHelpers.app_config_path,
      AppSpecHelpers.app_procfile_path,
      AppSpecHelpers.app_gitignore_path,
    ].each do |path_to_delete|
      FileUtils.rm_rf(path_to_delete)
    end
  end

  # Just remove formulae after each spec.
  config.after(:each) do
    FileUtils.rm_rf(brew_linked_formula_path)
    FileUtils.rm_rf(app_formulae_path + '*')
  end
end
