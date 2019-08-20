require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::WorldpayXml::Engine.root
  Workarea::Teaspoon.apply(config)
end
