require HOMEBREW_REPOSITORY / 'Library/Homebrew/cmd/tap'
require 'fileutils'

# Defines an apptap command for homebrew that configures homebrew to load
# formulae from a folder within the application.
module Homebrew
  def apptap_taps_path
    HOMEBREW_LIBRARY / 'Taps'
  end

  def apptap_formulae_path
    apptap_taps_path / 'local-formulae'
  end

  def install_apptap(tap_source_path)
    tap_source_path = Pathname.new(File.expand_path(tap_source_path))

    raise "Not a directory: #{tap_source_path}" unless Pathname.new(tap_source_path).directory?

    FileUtils.mkdir_p(apptap_formulae_path, :verbose => ARGV.debug?)
    FileUtils.rm_rf(Dir[apptap_formulae_path / '*'], :verbose => ARGV.debug?)
    FileUtils.cp_r(Dir[tap_source_path / '*'], apptap_formulae_path, :verbose => ARGV.debug?)
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
