module AppTap
  module CLI
    # Defines an action for updating app services.
    class Update < Thor::Group
      include Thor::Actions
      include AppTap::CLI::Helpers

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), '../../..'))
      end

      argument :service_name,
        desc: 'The name of the service to install.',
        required: true,
        type: :string

      def update_service
        say 'Updating services...'

        filter_config(service_name) do |config_name, service_config|
          say_status 'updating', config_name, :green
          if service_config['formula']
            run("#{brew_command} update #{service_config['formula']}")
          else
            say_status 'error', "Missing 'formula' configuration for #{config_name}.", :red
          end
        end
      end
    end
  end
end
