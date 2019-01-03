Pod::Spec.new do |s|

  s.swift_version = "4.2"

  s.name         = "Voxosonus"
  s.version      = "0.2.2"
  s.summary      = "Swift Text-Based Machine Learning for Humans"

  s.description  = <<-DESC
                    "A library to support developers' efforts in using Machine Learning in their iOS apps. Support for 12.x and upward."
                   DESC

  s.homepage     = "https://github.com/HeercoGrond/Voxosonus"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "HeercoGrond" => "heercogrond@live.nl" }

  s.platform     = :ios, "12.0"

  s.source       = { :git => "https://github.com/HeercoGrond/Voxosonus.git", :tag => "#{s.version}" }
  s.source_files  = "Voxosonus", "Voxosonus/**/*.{h,m,mlmodel}"
  s.exclude_files = "Voxosonus/Exclude"
end
