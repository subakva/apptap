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
        run("#{brew_command} apptap #{app_formulae_path}")
      end

      def install_missing_services
      end
    end
  end
end
