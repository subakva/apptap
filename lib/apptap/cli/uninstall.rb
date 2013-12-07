module AppTap
  module CLI
    # Defines an action for uninstalling app services.
    class Uninstall < Thor::Group
      include Thor::Actions
      include AppTap::CLI::Helpers

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), '../../..'))
      end

      def uninstall_apptap
        say 'Uninstalling...'
        remove_dir brew_install_path
        remove_file app_procfile_path
        remove_file app_config_path
      end
    end
  end
end
