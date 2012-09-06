require 'yaml'

module AppTap
  module CLI
    module Helpers
      def brew_dir
        '.brew'
      end

      def brew_repo_url
        'https://github.com/mxcl/homebrew.git'
      end

      def app_procfile_path
        'Procfile.dev'
      end

      def procfile_config_start_token
        '## START: AppTap Processes'
      end

      def procfile_config_end_token
        '## END: AppTap Processes'
      end

      def app_config_path
        File.join('config', 'apptap.yml')
      end

      def app_formulae_path
        File.join('config', 'formulae')
      end

      def app_ignore_path
        '.gitignore'
      end

      def brew_install_path
        File.join(destination_root, brew_dir)
      end

      def brew_cmds_path
        File.join(brew_install_path, 'Library', 'Contributions', 'cmds')
      end

      def brew_bin
        File.join(brew_install_path, 'bin')
      end

      def brew_command
        File.join(brew_bin, 'brew')
      end

      def formula_installed?(formula_name)
        run("#{brew_command} list #{formula_name}", verbose: false, capture: true) !~ /No such keg/
      end

      def load_config
        config_path = File.join(destination_root, app_config_path)
        config_data = File.read(config_path)
        YAML.load(config_data) || {}
      end

      def filter_config(service_name, config = nil, &block)
        config ||= self.load_config
        filtered_config = config
        if service_name && service_name.length > 0
          unless config.keys.include?(service_name)
            say_status 'error', "Unable to find a service called '#{service_name}'!", :red
          end
          filtered_config = config.select { |config_name| config_name == service_name }
        end

        if block_given?
          filtered_config.each do |name, service_config|
            yield(name, service_config)
          end
        end

        filtered_config
      end
    end
  end
end
