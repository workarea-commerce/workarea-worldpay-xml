module ActiveMerchant
  module Billing
    class BogusWorldpayGateway < BogusGateway
      def create_token(paysource, options= {})
        case normalize(paysource)
          when /1$/
            Response.new(
              true,
              SUCCESS_MESSAGE,
              { payment_token_id: SecureRandom.hex(10).upcase + '1' },
              :test => true,
              :authorization => AUTHORIZATION
            )
          when /2$/
            Response.new(
              false,
              FAILURE_MESSAGE,
              { payment_token_id: nil, error: FAILURE_MESSAGE },
              :test => true,
              :error_code => STANDARD_ERROR_CODE[:processing_error]
            )
          else
            raise Error, error_message(paysource)
        end
      end

      def authorize_swipe(money, paysource, options = {})
        money = amount(money)
        case normalize(paysource)
          when /2$/
            Response.new(false, FAILURE_MESSAGE, {:authorized_amount => money, :error => FAILURE_MESSAGE }, :test => true, :error_code => STANDARD_ERROR_CODE[:processing_error])
          when /3$/
            Response.new(false, FAILURE_MESSAGE, {:authorized_amount => money, :error => FAILURE_MESSAGE }, :test => true, :error_code => STANDARD_ERROR_CODE[:processing_error])
          else
            Response.new(true, SUCCESS_MESSAGE, {:authorized_amount => money}, :test => true, :authorization => AUTHORIZATION )
        end
      end

      def purchase_swipe(money, paysource, options = {})
        money = amount(money)
        case normalize(paysource)
          when /3$/
            raise Error, error_message(paysource)
          when /2$/
            Response.new(
              false,
              FAILURE_MESSAGE,
              {:paid_amount => money, :error => FAILURE_MESSAGE },
              :test => true,
              :error_code => STANDARD_ERROR_CODE[:processing_error]
            )
          else
            Response.new(
              true,
              SUCCESS_MESSAGE,
              {:paid_amount => money},
              :test => true,
              :authorization => AUTHORIZATION
            )
        end
      end
    end
  end
end

