# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'ViperWeather' do


pod 'Swinject', '~> 1.1.0'
pod 'Alamofire', '~> 3.5.0'

pod 'RealmSwift', '~> 0.98.5'
pod 'SwiftFetchedResultsController', '~> 3.0.1'

pod 'SwiftyJSON', '~> 2.3.2'

# Will used soon
pod 'SnapKit', '~> 0.22.0'

end

# Use Legacy Swift Language Version 2.3
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['SWIFT_VERSION'] = "2.3"
    end
  end
end