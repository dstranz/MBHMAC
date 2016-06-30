Pod::Spec.new do |s|
  s.name         = "MBHMAC+WatchOS"
  s.version      = "0.0.2"
  s.summary      = "HMAC additions for Objective-C NSString class."
  s.homepage     = "https://github.com/mborsten/MBHMAC"
  s.license      = 'MIT'
  s.author       = { "Marcel Borsten" => "mborsten@gmail.com" }
  s.source       = { :git => "https://github.com/dstranz/MBHMAC.git", :tag => "v0.0.2" }
  s.source_files = 'MBHMAC/*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '6.0'
  s.watchos.deployment_target = '2.0'
end
