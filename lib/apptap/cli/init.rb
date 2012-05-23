module AppTap
  module CLI
    class Init < Thor::Group
      include Thor::Actions
      include AppTap::CLI::Helpers

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), '../../..'))
      end

      def create_sample_config
        empty_directory(File.dirname(app_config_path))
        template('templates/config/apptap.yml.erb', app_config_path)
        template('templates/Procfile.dev.erb', app_procfile_path)
      end

      def install_homebrew
        if File.exists?(brew_install_path)
          say_status 'installed', 'Homebrew', :blue
        else
          run("git clone #{brew_repo_url} #{brew_install_path}")
        end
      end
    end
  end
end
