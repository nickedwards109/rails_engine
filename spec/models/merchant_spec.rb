require 'rails_helper'

RSpec.describe Merchant, type: :model do
    it "can find a merchant's total revenue across all successful transactions" do
      merchant = create(:merchant)
      success_invoice = create(:invoice, merchant_id: merchant.id)
      success_invoice_item1 = create(:invoice_item, unit_price: "2250",
                              invoice_id: success_invoice.id, quantity: 1)
      success_invoice_item2 = create(:invoice_item, unit_price: "2250",
                              invoice_id: success_invoice.id, quantity: 2)
      success_transaction_1 = create(:transaction, invoice_id: success_invoice.id,
                              result: "success")

      failed_invoice = create(:invoice, merchant_id: merchant.id)
      failed_invoice_item1 = create(:invoice_item, unit_price: "2250",
                             invoice_id: failed_invoice.id, quantity: 1)
      failed_transaction_1 = create(:transaction, invoice_id: failed_invoice.id,
                             result: "failed")

      expect(merchant.total_revenue_across_all_dates[:revenue]).to eq("6750.00")
    end

    it "can find a merchant's total revenue across all successful transactions, scoped to a date" do
      merchant = create(:merchant)
      date1 = "2012-03-16 11:55:05"
      date2 = "2012-03-17 11:55:05"
      invoice_date1 = create(:invoice, merchant_id: merchant.id, created_at: date1)
      invoice_item1_date1 = create(:invoice_item, unit_price: "2250",
                             invoice_id: invoice_date1.id, quantity: 1)
      invoice_item2_date1 = create(:invoice_item, unit_price: "2250",
                             invoice_id: invoice_date1.id, quantity: 2)
      transaction_date1 = create(:transaction, invoice_id: invoice_date1.id)

      invoice_date2 = create(:invoice, merchant_id: merchant.id, created_at: date2)
      invoice_item1_date2 = create(:invoice_item, unit_price: "2250",
                             invoice_id: invoice_date2.id, quantity: 1)
      invoice_item2_date2 = create(:invoice_item, unit_price: "2250",
                             invoice_id: invoice_date2.id, quantity: 1)
      transaction_date2 = create(:transaction, invoice_id: invoice_date2.id)

      expect(merchant.total_revenue_scoped_to(date1)[:revenue]).to eq("6750.00")
    end

    it "can find a variable number of top merchants ranked by revenue" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      invoice1 = create(:invoice, merchant_id: merchant1.id)
      invoice1_item1 = create(:invoice_item, unit_price: "5250",
                             invoice_id: invoice1.id, quantity: 1)
      invoice1_item2 = create(:invoice_item, unit_price: "5250",
                             invoice_id: invoice1.id, quantity: 2)
      transaction1 = create(:transaction, invoice_id: invoice1.id)

      invoice2 = create(:invoice, merchant_id: merchant2.id)
      invoice2_item1 = create(:invoice_item, unit_price: "2250",
                             invoice_id: invoice2.id, quantity: 1)
      invoice2_item2 = create(:invoice_item, unit_price: "2250",
                             invoice_id: invoice2.id, quantity: 2)
      transaction2 = create(:transaction, invoice_id: invoice2.id)

      expect(Merchant.top_ranked_by_revenue(1).first["id"]).to eq(merchant1.id)
      expect(Merchant.top_ranked_by_revenue(2).first["id"]).to eq(merchant1.id)
      expect(Merchant.top_ranked_by_revenue(2).last["id"]).to eq(merchant2.id)
    end

    it "can find a variable number of top merchants ranked by number of items sold" do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)

      invoice1 = create(:invoice, merchant_id: merchant1.id)
      invoice1_item1 = create(:invoice_item, invoice_id: invoice1.id, quantity: 5)
      invoice1_item2 = create(:invoice_item, invoice_id: invoice1.id, quantity: 5)
      transaction1 = create(:transaction, invoice_id: invoice1.id)

      invoice2 = create(:invoice, merchant_id: merchant2.id)
      invoice2_item1 = create(:invoice_item, invoice_id: invoice2.id, quantity: 1)
      invoice2_item2 = create(:invoice_item, invoice_id: invoice2.id, quantity: 1)
      transaction2 = create(:transaction, invoice_id: invoice2.id)

      expect(Merchant.top_ranked_by_items_sold(1).first["id"]).to eq(merchant1.id)
      expect(Merchant.top_ranked_by_items_sold(2).first["id"]).to eq(merchant1.id)
      expect(Merchant.top_ranked_by_items_sold(2).last["id"]).to eq(merchant2.id)
    end
end
