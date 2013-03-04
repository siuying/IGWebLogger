Pod::Spec.new do |s|
  s.name     = 'IGWebLogger'
  s.version  = '0.0.1'
  s.summary  = 'IGWebLogger allows you to view your iOS app logs over web browser in realtime.'
  
  s.homepage = 'https://github.com/siuying/ IGWebLogger'
  s.author   = { 'Francis Chong' => 'francis@ignition.hk' }
  s.license  = 'MIT'
  s.source   = { :git => 'https://github.com/siuying/IGWebLogger.git', :tag => '0.0.1' }
  s.requires_arc = true
  s.platform = :ios, '5.0'
  s.source_files = 'IGWebLogger/Classes/*.{m,h}'
  s.resources = 'IGWebLogger/Web/*.*'
  s.dependency "CocoaLumberjack", "~> 1.3.0"
  s.dependency "CocoaHTTPServer"
end