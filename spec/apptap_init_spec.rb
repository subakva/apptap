require 'spec_helper'

describe 'apptap' do
  def app_dir
    './tmp/app'
  end

  def config_dir
    File.join(app_dir , 'config')
  end

  def formulae_dir
    File.join(config_dir , 'formulae')
  end

  def brew_install_dir
    File.join(app_dir , '.brew')
  end

  def apptap_config_path
    File.join(config_dir , 'apptap.yml')
  end

  def procfile_path
    File.join(app_dir , 'Procfile.dev')
  end

  def gitignore_path
    File.join(app_dir , '.gitignore')
  end

  before(:all) do
    FileUtils.mkdir_p(app_dir)
    FileUtils.cp('./spec/fixtures/Gemfile', File.join(app_dir))
    FileUtils.touch(gitignore_path)
    FileUtils.chdir(app_dir) do
      `bundle`
      `bundle exec apptap init`
    end
  end

  after(:all) do
    # TODO: clean up the generated files, but maybe keep a pristine copy of .brew around
  end

  it 'generates a config file' do
    File.file?(apptap_config_path).should be_true
  end

  it 'generates an empty folder for formulae' do
    File.directory?(formulae_dir).should be_true
  end

  it 'generates a procfile' do
    File.file?(procfile_path).should be_true
  end

  it 'adds .brew to the .gitignore file' do
    File.file?(gitignore_path).should be_true
    File.read(gitignore_path).should =~ /\.brew/
  end

  it 'installs homebrew into .brew' do
    File.directory?(brew_install_dir).should be_true
    File.file?(File.join(brew_install_dir, 'bin', 'brew')).should be_true
  end

  it 'taps local formulae' do
    File.symlink?(File.join(brew_install_dir, 'Library', 'Taps', 'local-formulae')).should be_true
  end
end
