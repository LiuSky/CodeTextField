Pod::Spec.new do |s|

  s.name             = 'CodeTextField'
  s.version          = '0.1.0'
  s.summary          = '验证码文本组件'

  s.description      = <<-DESC
    验证码文本组件
                       DESC

  s.homepage         = 'https://github.com/LiuSky/CodeTextField'
  s.license          = 'MIT'
  s.author           = { 'xiaobin liu'=> '327847390@qq.com' }
  s.source           = { :git => 'https://github.com/LiuSky/CodeTextField.git', :tag => s.version.to_s }

  s.swift_version         = '5.0'
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.source_files = 'CodeTextField/Core/*.swift'
end

