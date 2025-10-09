Pod::Spec.new do |s|
  s.name         = "SafeConnection"
  s.version      = "0.5.25"
  s.summary      = "SafeConnection"
  s.description  = "SafeConnection iOS SDK"
  s.homepage     = "https://www.gogolook.com/"
  s.license      = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author       = 'GOGOLOOK Co., Ltd.'

  s.ios.deployment_target = '16'
  s.swift_version = '5.9'

  s.source = { 
    :http => 'https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.25/SafeConnection.xcframework.zip',
    :sha256 => '@@CHECKSUM@@'
  }

  s.vendored_frameworks = 'SafeConnection.xcframework'

  s.dependency 'RealmSwift', '10.54.5'

  s.prepare_command = <<-CMD
    # Download the XCFramework
    curl -L -o SafeConnection.xcframework.zip 'https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.5.25/SafeConnection.xcframework.zip'
    
    # Verify checksum
    echo "@@CHECKSUM@@  SafeConnection.xcframework.zip" | shasum -a 256 -c || exit 1
    
    # Extract the XCFramework
    unzip -o SafeConnection.xcframework.zip
    
    # Clean up
    rm -f SafeConnection.xcframework.zip
  CMD
end