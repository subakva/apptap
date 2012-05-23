require "apptap/version"
require 'thor'
require 'thor/group'

require 'apptap/cli/helpers'
require 'apptap/cli/init'
require 'apptap/cli/install'
require 'apptap/cli/foreman'

module AppTap
  module CLI
    class Root < Thor
      include Thor::Actions

      register AppTap::CLI::Init, 'init', 'init', 'Creates a sample apptap configuration file.'
      register AppTap::CLI::Install, 'install', 'install [SERVICE_NAME]', 'Installs SERVICE_NAME. If SERVICE_NAME is empty, installs all configured services.'
      register AppTap::CLI::Foreman, 'foreman', 'foreman [COMMAND]', 'Executes a foreman command.'
    end
  end
end
