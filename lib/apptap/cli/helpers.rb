require 'yaml'

module AppTap
  module CLI
    # Defines common configuration and helper methods used within thor actions
    module Helpers

      def app_root
        Pathname.new(File.expand_path(destination_root))
      end

      def app_ignore_file
        app_root + '.gitignore'
      end

      def app_procfile_file
        app_root + 'Procfile.dev'
      end

      def app_config_dir
        app_root + 'config'
      end

      def app_config_file
        app_config_dir + 'apptap.yml'
      end

      def app_formulae_dir
        app_config_dir + 'formulae'
      end

      def brew_dir_name
        '.brew'
      end

      def brew_install_dir
        app_root + brew_dir_name
      end

      def brew_cmd_dir
        brew_install_dir + 'Library' + 'Contributions' + 'cmd'
      end

      def brew_bin_dir
        brew_install_dir + 'bin'
      end

      def brew_command
        brew_bin_dir + 'brew'
      end

      def git_command
        'git'
      end

      def procfile_config_start_token
        '## START: AppTap Processes'
      end

      def procfile_config_end_token
        '## END: AppTap Processes'
      end

      def brew_repo_url
        'https://github.com/mxcl/homebrew.git'
      end

      def run_brew(args, options = nil)
        options ||= {}
        result = nil
        Bundler.with_clean_env do
          # result = run("#{brew_command} -vd #{args}", options)
          result = run("#{brew_command} #{args}", options)
        end
        result
      end

      # Returns true if a formula with that name has been installed.
      def formula_installed?(formula_name)
        result = run_brew("info #{formula_name}", verbose: false, capture: true)
        result !~ /Not installed/ && result !~ /No available formula/
      end

      # Loads the application config file into hash.
      def load_config
        config_data = File.read(app_config_file)
        YAML.load(config_data) || {}
      end

      def filter_config(service_name, config = nil, &block)
        config ||= load_config
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

      def install_service(service_name, service_config)
        say_status 'installing', service_name, :green
        formula_name = service_config['formula']
        if formula_name
          if formula_installed?(formula_name)
            message = "#{formula_name} already installed."
            say_status('installed', message, :yellow)
          else
            run_brew("install #{formula_name}")
          end
        else
          say_status 'error', "Missing 'formula' configuration for #{service_name}.", :red
        end
      end
    end
  end
end
