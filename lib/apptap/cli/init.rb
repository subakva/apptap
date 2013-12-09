module AppTap
  module CLI
    # Defines an action for initializing an app to use apptap services.
    class Init < Thor::Group
      include Thor::Actions
      include AppTap::CLI::Helpers

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), '../../..'))
      end

      def create_sample_config
        empty_directory(File.dirname(app_config_dir))
        empty_directory(app_formulae_dir)
        template('templates/config/apptap.yml.erb', app_config_file)
        template('templates/Procfile.dev.erb', app_procfile_file)
      end

      def update_gitignore
        say_status 'updating', app_ignore_file, :green

        if File.exists?(app_ignore_file) && File.read(app_ignore_file) !~ Regexp.new(brew_dir_name)
          append_to_file(app_ignore_file, "#{brew_dir_name}\n")
        end
      end

      def install_homebrew
        if File.exists?(brew_install_dir)
          say_status 'installed', 'Homebrew', :blue
        else
          run("#{git_command} clone #{brew_repo_url} #{brew_install_dir}")
        end
      end

      def symlink_local_tap
        say_status 'tapping', app_formulae_dir, :green
        directory('templates/Library/Contributions/cmd', brew_cmd_dir, force: true)
        chmod File.join(brew_cmd_dir, 'brew-apptap.rb'), 0755
        run_brew("apptap #{app_formulae_dir}")
      end
    end
  end
end
