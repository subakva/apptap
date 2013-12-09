module AppTap
  module CLI
    # Defines an action for updating app formulae.
    class Update < Thor::Group
      include Thor::Actions
      include AppTap::CLI::Helpers

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), '../../..'))
      end

      def update_formulae
        say 'Updating formulae...'
        run_brew("apptap #{app_formulae_dir}")
      end

      def install_missing_services
        say 'Installing services...'
        config = load_config
        config.each do |service_name, service_config|
          install_service(service_name, service_config)
        end
      end
    end
  end
end
