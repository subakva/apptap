require HOMEBREW_REPOSITORY/"Library/Homebrew/cmd/tap"
require 'fileutils'

module Homebrew extend self
  def install_apptap tap_source_path
    tap_source_path = File.expand_path(tap_source_path)
    taps_dir = HOMEBREW_LIBRARY / 'Taps'
    tapd = taps_dir / 'local-formulae'

    raise 'Already tapped!' if tapd.directory?
    raise "Not a directory: #{tap_source_path}" unless Pathname.new(tap_source_path).directory?

    FileUtils.mkdir_p(taps_dir)
    relative_path = Pathname.new(tap_source_path).relative_path_from(taps_dir)
    FileUtils.ln_s(relative_path, tapd)
    raise 'Unable to copy files!' unless tapd.directory?

    files = []
    tapd.find_formula { |file| files << tapd.basename.join(file) }
    tapped = link_tap_formula(files)
    puts "Tapped #{tapped} formula"
  end

  def apptap
    tap_source_path = ARGV.first
    raise 'Invalid usage' unless tap_source_path
    install_apptap(tap_source_path)
  end
end

Homebrew.apptap
