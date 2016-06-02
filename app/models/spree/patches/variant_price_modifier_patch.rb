module Spree
  module Patches::VariantPriceModifierPatch
    # Calculates the sum of the specified price modifiers in the specified
    # currency.
    #
    # @deprecated This is a very complex way of modifying prices, please write a pricer instead
    # @param currency [String] (see #price)
    # @param options (see #price_modifier_amount)
    # @return (see #price_modifier_amount)
    def price_modifier_amount_in(currency, options = {})
      return 0 unless options.present?

      options.keys.map { |key|
        m = "#{key}_price_modifier_amount_in".to_sym
        if respond_to? m
          send(m, currency, options[key])
        else
          0
        end
      }.sum
    end
    # deprecate :price_modifier_amount_in, deprecator: Spree::Deprecation

    # Calculates the sum of the specified price modifiers.
    #
    # @deprecated This method does not handle currencies
    # @param options [Hash] for specifying keys, eg: `{keys: ['key_1', 'key_2']}`
    # @return [Fixnum] the sum
    def price_modifier_amount(options = {})
      return 0 unless options.present?

      options.keys.map { |key|
        m = "#{options[key]}_price_modifier_amount".to_sym
        if respond_to? m
          send(m, options[key])
        else
          0
        end
      }.sum
    end
    # deprecate :price_modifier_amount, deprecator: Spree::Deprecation
  end
end
