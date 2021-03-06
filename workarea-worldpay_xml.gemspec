$:.push File.expand_path('../lib', __FILE__)

require 'workarea/worldpay_xml/version'

Gem::Specification.new do |s|
  s.name        = 'workarea-worldpay_xml'
  s.version     = Workarea::WorldpayXml::VERSION
  s.authors     = ['Jeff Yucis']
  s.email       = ['jyucis@weblinc.com']
  s.homepage    = 'https://github.com/workarea-commerce/workarea-worldpay-xml'
  s.summary     = 'Integrates Worldpay with Workarea Commerce Platform'
  s.description = 'Integrates Worldpay with Workarea Commerce Platform using the XML API.'
  s.files = `git ls-files`.split("\n")
  s.license = 'Business Software License'

  s.add_dependency 'workarea', '~> 3.x'
end
