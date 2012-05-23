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

      def brew_install_path
        File.join(destination_root, brew_dir)
      end

      def brew_bin
        File.join(brew_install_path, 'bin')
      end

      def brew_command
        File.join(brew_bin, 'brew')
      end

      def load_config
        YAML.load_file(File.join(destination_root, app_config_path))
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
