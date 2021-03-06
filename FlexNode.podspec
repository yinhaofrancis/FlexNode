#
# Be sure to run `pod lib lint FlexNode.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FlexNode'
  s.version          = '0.1.0'
  s.summary          = 'flex 布局库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS Flex 布局库 部分flex 属性支持
                       DESC

  s.homepage         = 'https://github.com/yinhaoFrancis/FlexNode'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yinhaoFrancis' => '1833918721@qq.com' }
  s.source           = { :git => 'https://github.com/yinhaoFrancis/FlexNode.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'FlexNode/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FlexNode' => ['FlexNode/Assets/*.png']
  # }

   s.public_header_files = 'FlexNode/Classes/**/*.h'
  s.frameworks = 'CoreServices'
  # s.dependency 'AFNetworking', '~> 2.3'
end
