require "spec_helper"

describe Spree::Variant::GiftWrapPricingOptions do
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

  describe '#line_item_options' do
    let(:line_item) { build_stubbed(:line_item) }

    subject { described_class.from_line_item(line_item).line_item_options }

    context "if gift wrap is true" do
      before { line_item.gift_wrap = true }

      it { is_expected.to eq({ gift_wrap: true }) }
    end

    context "if gift wrap is false" do
      before { line_item.gift_wrap = false }

      it { is_expected.to eq({ gift_wrap: false }) }
    end

    context "when initialized without a line item" do
      subject { described_class.new(currency: "EUR").line_item_options }

      it { is_expected.to eq({}) }
    end
  end

  describe '#desired_attributes' do
    let(:line_item) { build_stubbed(:line_item) }
    let(:order) { line_item.order }

    before { expect(order).to receive(:currency).and_return(currency) }

    subject { described_class.from_line_item(line_item).desired_attributes }

    context "if the order is in RUB" do
      let(:currency) { "RUB" }

      it { is_expected.to include({ currency: "RUB" }) }
    end

    context "if gift wrap is false" do
      let(:currency) { "EUR" }

      it { is_expected.to include({ currency: "EUR" }) }
    end
  end
end
