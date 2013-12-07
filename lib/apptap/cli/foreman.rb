module AppTap
  module CLI
    # Defines an action for managing the formean config for app services.
    class Foreman < Thor
      include Thor::Actions
      include AppTap::CLI::Helpers

      # argument :command,
      #   desc: 'The name of the foreman command to execute.',
      #   required: false,
      #   type: :string

      desc 'start', 'Starts the foreman process'
      def start
        run "foreman start -f #{app_procfile_path}"
        # Process.exec "foreman -f #{app_procfile_path}"
      end
    end
  end
end
