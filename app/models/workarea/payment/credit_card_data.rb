module Workarea
  class Payment
    module CreditCardData
      def billing_address
        {
          name:       "#{address.first_name} #{address.last_name}",
          company:    address.company,
          address1:   address.street,
          city:       address.city,
          state:      address.region,
          country:    address.country.try(:alpha2),
          zip:        address.postal_code,
          phone:      nil
        }
      end

      def order
        @order ||= Workarea::Order.find(tender.payment.id)
      end

      def order_content
        @order_content ||= begin
          contents = order.items.map { |oi| oi.sku }.join(',')
          "Env: #{Rails.env}, Items: #{contents}"
        end
      end

      def currency_code
        @currency_code = order.total_price.currency.iso_code
      end

      # Worldpay requires a unique order code per transaction, even
      # if the transaction was a failure and a new card is used.
      # Appending the time stamp gives some historical context
      # in the payment admin
      #
      #  !!!! A duplicate order code could cause a users credit card
      #  to be charged multiple times. Make sure this method returns a unique
      #  value each time. !!!!
      def order_id
        @order_id ||= begin
          stamp = DateTime.now.strftime('%Y_%m_%d_%H_%M_%S')
          "#{tender.payment.id}_#{stamp}"
        end
      end
    end
  end
end
