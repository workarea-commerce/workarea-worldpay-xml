module Workarea
  module WorldpayXml
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::WorldpayXml
    end
  end
end
