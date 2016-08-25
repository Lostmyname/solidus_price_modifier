require "spec_helper"

describe Spree::Variant::GiftWrapPricer do
  before :context do
    Spree::LineItem.class_eval do
      attr_accessor :gift_wrap
    end
    Spree::Variant.class_eval do
      def gift_wrap_price_modifier_amount_in(_currency, value)
        value ? 2 : 0
      end
    end
  end

  after :context do
    Spree::LineItem.class_eval do
      remove_method :gift_wrap
      remove_method :gift_wrap=
    end
    Spree::Variant.class_eval do
      remove_method :gift_wrap_price_modifier_amount_in
    end
  end

  before :each do
    Spree::Config.variant_price_selector_class = described_class
  end

  describe '.pricing_options_class' do
    subject { described_class.pricing_options_class }

    it { is_expected.to eq(Spree::Variant::GiftWrapPricingOptions) }
  end

  describe '#price_for' do
    let(:variant) { create(:variant) }
    let(:line_item_options) { line_item.pricing_options }

    subject { described_class.new(variant).price_for(line_item_options) }

    context "without gift wrapping" do
      let(:line_item) { create(:line_item, gift_wrap: false) }

      it "returns the default price of the variant" do
        Spree::Deprecation.silence do
          is_expected.to eq(variant.default_price.money)
        end
      end
    end

    context "with gift wrapping" do
      let(:line_item) { create(:line_item, gift_wrap: true) }

      it "returns the price of the variant plus two for gift wrapping" do
        Spree::Deprecation.silence do
          is_expected.to eq(
            variant.default_price.money + Spree::Money.new(2, currency: Spree::Config.currency)
          )
        end
      end
    end
  end
end
