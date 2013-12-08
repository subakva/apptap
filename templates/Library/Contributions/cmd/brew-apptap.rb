require HOMEBREW_REPOSITORY / 'Library/Homebrew/cmd/tap'
require 'fileutils'

# Defines an apptap command for homebrew that configures homebrew to load
# formulae from a folder within the application.
module Homebrew
  def apptap_taps_dir
    HOMEBREW_LIBRARY / 'Taps'
  end

  def apptap_formulae_dir
    apptap_taps_dir / 'local-formulae'
  end

  def install_apptap(tap_source_path)
    tap_source_path = File.expand_path(tap_source_path)

    raise "Not a directory: #{tap_source_path}" unless Pathname.new(tap_source_path).directory?

    FileUtils.mkdir_p(apptap_taps_dir)
    FileUtils.rm_rf(apptap_formulae_dir)
    FileUtils.cp_r(tap_source_path, apptap_formulae_dir)
    repair_taps
  end

  def apptap
    tap_source_path = ARGV.first
    raise 'Invalid usage' unless tap_source_path
    install_apptap(tap_source_path)
  end
  module_function :apptap
end

Homebrew.apptap
