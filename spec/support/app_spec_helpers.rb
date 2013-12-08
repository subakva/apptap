module AppSpecHelpers
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
end
