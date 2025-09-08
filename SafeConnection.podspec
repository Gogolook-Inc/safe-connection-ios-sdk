Pod::Spec.new do |s|
  s.name         = "SafeConnection"
  s.version      = "0.4.1"
  s.summary      = "SafeConnection"
  s.description  = "SafeConnection iOS SDK"
  s.homepage     = "https://www.gogolook.com/"
  s.license      = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author       = 'GOGOLOOK Co., Ltd.'

  s.source = { :http => 'https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.4.1/SafeConnection.xcframework.zip' }

  s.vendored_frameworks = 'SafeConnection.xcframework'

  s.prepare_command = <<-CMD
    curl -L -o SafeConnection.xcframework.zip 'https://github.com/Gogolook-Inc/safe-connection-ios-sdk/releases/download/0.4.1/SafeConnection.xcframework.zip'
    unzip SafeConnection.xcframework.zip
    rm -f SafeConnection.xcframework.zip
  CMD
end