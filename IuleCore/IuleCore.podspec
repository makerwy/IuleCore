
Pod::Spec.new do |s|
  s.name         = "IuleCore"
  s.version      = "0.0.1"
  s.summary      = "IuleCore"
  s.description  = <<-DESC
                  IuleCore
                   DESC
  s.homepage     = "www.iule.cn"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/stefenw/IuleCore', :tag => s.version }
  s.source_files  = "IuleCore/**/*.{h,m}"
  #s.resources = ["IuleCore/IuleCore/Bundle/IuleSDK.bundle","IuleCore/IuleCore/Bundle/IuleRefresh.bundle"]
  #s.vendored_frameworks = 'IuleCore/IuleCore/Bundle/IuleRefresh.framework'
  #s.resources = "../product/debug/IuleSDK.bundle"
  s.requires_arc = true

end

