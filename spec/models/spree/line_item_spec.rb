require 'spec_helper'

describe Spree::LineItem, type: :model do
  let(:order) { create :order_with_line_items, line_items_count: 1 }
  let(:line_item) { order.line_items.first }

  context "when using the gift wrap pricer" do
    before do
      Spree::Config.variant_price_selector_class = Spree::Variant::GiftWrapPricer
    end

    it "updates the price based on the options provided" do
      expect(line_item).to receive(:gift_wrap=).with(true)
      expect(line_item).to receive(:gift_wrap).at_least(:once).and_return(true)
      expect(line_item.variant).to receive(:gift_wrap_price_modifier_amount_in).with("USD", true).at_least(:once).and_return 1.99
      line_item.options = { gift_wrap: true }
      expect(line_item.price).to eq 21.98
    end
  end
end
