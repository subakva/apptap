module AppTap
  module CLI
    class Install < Thor::Group
      include Thor::Actions
      include AppTap::CLI::Helpers

      argument :service_name,
        desc: 'The name of the service to install.',
        required: false,
        type: :string

      def install_services
        say "Installing services..."

        filter_config(service_name) do |config_name, service_config|
          say_status 'installing', config_name, :green
          if service_config['formula']
            run("#{brew_command} install #{service_config['formula']}")
          else
            say_status 'error', "Missing 'formula' configuration for #{config_name}.", :red
          end
        end
      end

      def reset_procfile
        say_status 'resetting', app_procfile_path, :green

        apptap_section_regexp = Regexp.new("#{procfile_config_start_token}(.*)#{procfile_config_end_token}", Regexp::MULTILINE)
        gsub_file app_procfile_path, apptap_section_regexp do |match|
          "#{procfile_config_start_token}\n#{procfile_config_end_token}"
        end
      end

      def symlink_local_tap
        say_status 'Setting up local Tap...', app_procfile_path, :green
        # copy_file brew-apptap.rb .brew/Library/Contributions/cmds/brew-apptap.rb
        # chmod +x .brew/Library/Contributions/cmds/brew-apptap.rb
        # mkdir -p config/formulae
        # .brew/bin/brew apptap config/formulae
        # TODO: Figure out how to blow away and rebuild the formulae?
      end

      def generate_procfile
        say_status 'updating', app_procfile_path, :green

        filter_config(service_name) do |config_name, service_config|
          say_status 'adding', config_name, :green

          insert_into_file(app_procfile_path, after: "#{procfile_config_start_token}\n") do
            command = service_config['command']
            process_name = config_name

            "#{process_name}: #{File.join(brew_bin, command)}\n"
          end
        end
      end
    end
  end
end
