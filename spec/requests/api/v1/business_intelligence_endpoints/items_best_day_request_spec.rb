require 'rails_helper'

  describe "best_day" do
   it 'returns the day with the greatest quantity sold for a given item' do
     merchant = create(:merchant)
     item = create(:item, merchant_id: merchant.id)
     invoice_1, invoice_2, invoice_3 = create_list(:invoice, 3, created_at: "2017-06-29T20:35:11.688Z")
     invoice_4 = create(:invoice, created_at: "2017-06-30T21:12:12.685Z" )
     create(:invoice_item, item: item, invoice: invoice_1, quantity: 1)
     create(:invoice_item, item: item, invoice: invoice_2, quantity: 2)
     create(:invoice_item, item: item, invoice: invoice_3, quantity: 3)
    create(:invoice_item, item: item, invoice: invoice_4, quantity: 3)
     get "/api/v1/items/#{item.id}/best_day"

     expect(response).to be_success

     item_json = JSON.parse(response.body)

     expect(item_json["best_day"]).to eq("2017-06-29T20:35:11.688Z")
     expect(item_json["best_day"]).to_not eq("2017-06-30T21:12:12.685Z")
   end
 end