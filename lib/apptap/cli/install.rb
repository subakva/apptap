module AppTap
  module CLI
    # Defines an action for installing app services.
    class Install < Thor::Group
      include Thor::Actions
      include AppTap::CLI::Helpers

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), '../../..'))
      end

      argument :service_name,
        desc: 'The name of the service to install.',
        required: false,
        type: :string

      def install_services
        say 'Installing services...'

        filter_config(service_name) do |config_name, service_config|
          say_status 'installing', config_name, :green
          install_service(config_name, service_config)
        end
      end

      def reset_procfile
        say_status 'resetting', app_procfile_path, :green

        apptap_section_regexp = Regexp.new(
          "#{procfile_config_start_token}(.*)#{procfile_config_end_token}",
          Regexp::MULTILINE
        )
        gsub_file app_procfile_path, apptap_section_regexp do |match|
          "#{procfile_config_start_token}\n#{procfile_config_end_token}"
        end
      end

      def generate_procfile
        say_status 'updating', app_procfile_path, :green

        filter_config(service_name) do |config_name, service_config|
          command = service_config['command']
          next if command.nil?

          say_status 'adding', config_name, :green

          insert_into_file(app_procfile_path, after: "#{procfile_config_start_token}\n") do
            process_name = config_name
            "#{process_name}: #{File.join(brew_bin, command)}\n"
          end
        end
      end
    end
  end
end
