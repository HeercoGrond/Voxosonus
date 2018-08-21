#
# Be sure to run `pod lib lint Voxosonus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Voxosonus'
  s.version          = '0.1.0'
  s.summary          = 'A Speech Recognition Framework to recognize intent in spoken sentences for use with own models.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Voxosonus is a Speech Recognition Framework that combines the CoreML and Speech libraries to build a simple and easily implemented solution for recognizing the intent in a sentence.
                       DESC

  s.homepage         = 'https://github.com/HeercoGrond/Voxosonus'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Heerco_Grond' => 'heercogrond@live.nl' }
  s.source           = { :git => 'https://github.com/HeercoGrond/Voxosonus.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Voxosonus/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Voxosonus' => ['Voxosonus/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
