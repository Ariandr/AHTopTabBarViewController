Pod::Spec.new do |s|
  s.name = 'AHTopTabBarViewController'
  s.version = '0.1.0'
  s.summary = 'View controller for managing tabs on the top of a screen in iOS apps'
  s.description = <<-DESC
                  View controller for managing tabs on the top of a screen in iOS apps.
                  Highly customizable.
                  DESC
  s.homepage = 'https://github.com/Ariandr/AHTopTabBarViewController'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Aleksandr Honcharov' => 'sanya.goncharov.1995@gmail.com' }
  s.source = { :git => 'https://github.com/Ariandr/AHTopTabBarViewController.git', :tag => s.version.to_s }
  s.swift_version = '4.0'
  
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  
  s.source_files = 'Source/**/*'

  s.frameworks = 'UIKit'
end
