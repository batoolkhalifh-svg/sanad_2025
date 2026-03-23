# frozen_string_literal: true

require 'fileutils'

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join(__dir__, "..", "Flutter", "Generated.xcconfig"))
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.read(generated_xcode_build_settings_path).match(/FLUTTER_ROOT\=(.*)/)[1]
end

def parse_KV_file(file, delimiter='=')
  map = {}
  File.foreach(file) do |line|
    next if line.strip.empty? || line.strip.start_with?('#')
    key, value = line.strip.split(delimiter, 2)
    map[key.strip] = value.strip if key && value
  end
  map
end

def symlink_flutter_frameworks
  symlink_dir = File.expand_path(File.join(__dir__, '..', 'Flutter'))
  FileUtils.mkdir_p(symlink_dir)
end
