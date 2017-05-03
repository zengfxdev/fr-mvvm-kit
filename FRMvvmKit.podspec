#
#  Be sure to run `pod spec lint FRMvvmKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "FRMvvmKit"
  s.version      = "0.0.2"
  s.summary      = "A short description of FRMvvmKit."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/zengfxios/fr-mvvm-kit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "zengfxios" => "zengfxios@gmail.com" }

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/zengfxios/fr-mvvm-kit.git", :tag => "#{s.version}" }

  s.source_files  = 'FRMvvmKit/Classes/**/*'

  s.dependency 'ReactiveObjC'
  s.dependency 'Masonry'
  s.dependency 'AFNetworking', '~> 3.0'
end
