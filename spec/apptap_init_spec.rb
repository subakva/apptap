require 'spec_helper'

describe 'apptap init' do
  it 'generates a config file' do
    File.file?(app_config_yml_path).should be_true
  end

  it 'generates an empty folder for formulae' do
    File.directory?(app_formulae_path).should be_true
  end

  it 'generates a procfile' do
    File.file?(app_procfile_path).should be_true
  end

  it 'adds .brew to the .gitignore file' do
    File.file?(app_gitignore_path).should be_true
    File.read(app_gitignore_path).should =~ /\.brew/
  end

  it 'installs homebrew into .brew' do
    File.directory?(brew_install_path).should be_true
    File.file?(File.join(brew_install_path, 'bin', 'brew')).should be_true
  end

  it 'taps local formulae' do
    File.directory?(brew_local_tap_path).should be_true
  end
end
