require 'workarea'
require 'workarea/storefront'
require 'workarea/admin'

require 'workarea/worldpay_xml/engine'
require 'workarea/worldpay_xml/version'

require 'active_merchant/billing/bogus_worldpay_gateway'
require 'active_merchant/billing/worldpay_tokenize'


module Workarea
  module WorldpayXml
    # Credentials for WorldpayGateway from Rails secrets.
    #
    # @return [Hash]
    def self.credentials
      return {} unless Rails.application.secrets.worldpay.present?
      Rails.application.secrets.worldpay.symbolize_keys
    end

    # Conditionally use the real gateway when secrets are present.
    # Otherwise, use the bogus gateway.
    #
    # @return [ActiveMerchant::Billing::Gateway]
    def self.gateway
      Workarea.config.gateways.credit_card
    end

    def self.gateway=(gateway)
      Workarea.config.gateways.credit_card = gateway
    end

    def self.auto_initialize_gateway
      if credentials.present?
        if ENV['HTTP_PROXY'].present?
          uri = URI.parse(ENV['HTTP_PROXY'])
          ActiveMerchant::Billing::WorldpayGateway.proxy_address = uri.host
          ActiveMerchant::Billing::WorldpayGateway.proxy_port = uri.port
        end

        self.gateway = ActiveMerchant::Billing::WorldpayGateway.new credentials
      else
        self.gateway = ActiveMerchant::Billing::BogusWorldpayGateway.new
      end
    end
  end
end
