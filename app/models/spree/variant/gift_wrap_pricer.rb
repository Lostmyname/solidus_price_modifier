module Spree
  class Variant
    class GiftWrapPricer < Spree::Variant::PriceSelector
      def self.pricing_options_class
        Spree::Variant::GiftWrapPricingOptions
      end

      def price_for(pricing_options)
        super + Spree::Money.new(
          variant.price_modifier_amount_in(pricing_options.currency, pricing_options.line_item_options),
          currency: pricing_options.currency
        )
      end
    end
  end
end
