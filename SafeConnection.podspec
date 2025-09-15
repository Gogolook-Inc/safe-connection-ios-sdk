Pod::Spec.new do |s|
  s.name         = "SafeConnection"
  s.version      = "0.5.18"
  s.summary      = "SafeConnection"
  s.description  = "SafeConnection iOS SDK"
  s.homepage     = "https://www.gogolook.com/"
  s.license      = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author       = 'GOGOLOOK Co., Ltd.'

  s.ios.deployment_target = '16'

  s.source = { :http => 'https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.18/SafeConnection.xcframework.zip' }

  s.vendored_frameworks = 'SafeConnection.xcframework'

  s.dependency 'RealmSwift', '10.54.5'

  s.prepare_command = <<-CMD
    curl -L -o SafeConnection.xcframework.zip 'https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.18/SafeConnection.xcframework.zip'
    unzip SafeConnection.xcframework.zip
    rm -f SafeConnection.xcframework.zip
  CMD
end