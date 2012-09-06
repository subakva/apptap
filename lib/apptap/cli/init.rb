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
        empty_directory(app_formulae_path)
        template('templates/config/apptap.yml.erb', app_config_path)
        template('templates/Procfile.dev.erb', app_procfile_path)
      end

      def update_gitignore
        say_status 'updating', app_ignore_path, :green

        if File.exists?(app_ignore_path) && File.read(app_ignore_path) !~ /.brew/
          append_to_file(app_ignore_path, ".brew\n")
        end
      end

      def install_homebrew
        if File.exists?(brew_install_path)
          say_status 'installed', 'Homebrew', :blue
        else
          run("git clone #{brew_repo_url} #{brew_install_path}")
        end
      end

      def symlink_local_tap
        say_status 'tapping', app_formulae_path, :green
        directory('templates/Library/Contributions/cmds', brew_cmds_path, force: true)
        chmod File.join(brew_cmds_path, "brew-apptap.rb"), 0755
        run("#{brew_command} apptap #{app_formulae_path}")
      end
    end
  end
end
