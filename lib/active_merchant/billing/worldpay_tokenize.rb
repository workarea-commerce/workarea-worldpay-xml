ActiveMerchant::Billing::WorldpayGateway.class_eval do
  def create_token(payment_method, options = {})
    requires!(options, :order_id)
    create_token_request(payment_method, options)
  end

  private

  def create_token_request(payment_method, options)
    commit('payment_token_create', build_create_token_request(payment_method, options), nil)
  end

  def build_create_token_request(payment_method, options)
    build_request do |xml|
      xml.tag! 'submit' do
        xml.tag! 'paymentTokenCreate' do
          xml.tag! 'authenticatedShopperID', options[:shopper_id]
          add_token_details(xml, options)
          add_token_payment_method(xml, payment_method, options)
        end
      end
    end
  end

  def add_token_details(xml, options)
    return unless options[:order_id]
    xml.tag! 'createToken' do
      xml.tag! 'tokenEventReference', options[:order_id]
      xml.tag! 'tokenReason', 'Saved payment method'
    end
  end

  def add_token_payment_method(xml, payment_method, options)
    return unless options[:order_id]
    xml.tag! 'paymentInstrument' do
      xml.tag! 'cardDetails' do
        xml.tag! 'cardNumber', payment_method.number
        xml.tag! 'expiryDate' do
          xml.tag! 'date', 'month' => format(payment_method.month, :two_digits), 'year' => format(payment_method.year, :four_digits)
        end
        xml.tag! 'cardHolderName', payment_method.name
        xml.tag! 'cvc', payment_method.verification_value
      end
      add_address(xml, (options[:billing_address] || options[:address]))
    end
  end

  # success_criteria can be:
  #   - a string or an array of strings (if one of many responses)
  #   - An array of strings if one of many responses could be considered a
  #     success.
  #   - if empty then look for error codes
  def success_and_message_from(raw, success_criteria)
    success = if success_criteria.compact.empty?
      !(raw[:error].present? && raw[:error_code].present?)
    else
      (success_criteria.include?(raw[:last_event]) || raw[:ok].present?)
    end

    if success
      message = "SUCCESS"
    else
      message = (raw[:iso8583_return_code_description] || raw[:error] || required_status_message(raw, success_criteria))
    end

    [ success, message ]
  end

  def add_payment_method(xml, amount, payment_method, options)
    if payment_method.is_a?(String)
      if options[:merchant_code]
        xml.tag! 'payAsOrder', 'orderCode' => payment_method, 'merchantCode' => options[:merchant_code] do
          add_amount(xml, amount, options)
        end
      elsif options[:pay_by_token]
        xml.tag! 'paymentDetails' do
          xml.tag! 'TOKEN-SSL', 'tokenScope' => 'shopper' do
            xml.tag! 'paymentTokenID', payment_method
          end
        end
      else
        xml.tag! 'payAsOrder', 'orderCode' => payment_method do
          add_amount(xml, amount, options)
        end
      end
    else
      xml.tag! 'paymentDetails' do
        xml.tag! CARD_CODES[card_brand(payment_method)] do
          xml.tag! 'cardNumber', payment_method.number
          xml.tag! 'expiryDate' do
            xml.tag! 'date', 'month' => format(payment_method.month, :two_digits), 'year' => format(payment_method.year, :four_digits)
          end

          xml.tag! 'cardHolderName', payment_method.name
          xml.tag! 'cvc', payment_method.verification_value

          add_address(xml, (options[:billing_address] || options[:address]))
        end
        if options[:ip] && options[:session_id]
          xml.tag! 'session', 'shopperIPAddress' => options[:ip], 'id' => options[:session_id]
        else
          xml.tag! 'session', 'shopperIPAddress' => options[:ip] if options[:ip]
          xml.tag! 'session', 'id' => options[:session_id] if options[:session_id]
        end
      end
    end
  end

  def add_email(xml, options)
    return unless options[:email]
    xml.tag! 'shopper' do
      xml.tag! 'shopperEmailAddress', options[:email]
      if options[:pay_by_token]
        xml.tag! 'authenticatedShopperID', options[:shopper_id]
      end
    end
  end
end
