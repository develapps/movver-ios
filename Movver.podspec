#
# Be sure to run `pod lib lint movver-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Movver'
  s.version          = '2.1.2'
  s.summary          = 'An implementation of MOVVER protocol with some helpers.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is an implementation of develapps MOVVER architecture. This is a clean architecture that tries to
separate responsibilities but without tons of boilerplate code. See the example for more.

v2.1.0: Implements deep linking with routes
                       DESC

  s.homepage         = 'https://github.com/develapps/movver-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pablo Romeu' => 'pablo.romeu@develapps.com' }
  s.source           = { :git => 'https://github.com/develapps/movver-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/pabloromeu'

  s.ios.deployment_target = '9.0'

  s.source_files = 'movver-ios/Classes/**/*'
  
  # s.resource_bundles = {
  #   'movver-ios' => ['movver-ios/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
