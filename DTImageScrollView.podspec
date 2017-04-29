Pod::Spec.new do |s|
  s.name         = "DTImageScrollView"
  s.version      = "0.0.7"
  s.summary      = "An easy way to create a swipable set of images with paging indicator."
  s.homepage     = "https://github.com/daront/DTImageScrollView"
  s.license      = "MIT"
  #s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Daron Tancharoen" => "daront@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/daront/DTImageScrollView.git", :tag => "#{s.version}" }
  s.source_files  = "DTImageScrollView/*.{swift}"
  s.exclude_files = "Classes/Exclude"
  s.dependency 'AlamofireImage'

end
