require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices.json'

    expect(response).to be_success

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(3)

    invoice = invoices.first
    expect(invoice).to have_key("status")
  end

  it "sends a single invoice" do
    invoice = create(:invoice)
    id = invoice.id

    get "/api/v1/invoices/#{id}.json"
    expect(response).to be_success

    raw_invoice = JSON.parse(response.body)
    expect(raw_invoice["status"]).to eq(invoice.status)
  end

  it "sends an invoice selected by id, status, created_at, or updated_at" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"
    expect(response).to be_success
    raw_invoice = JSON.parse(response.body)
    expect(raw_invoice["id"]).to eq(invoice.id)

    get "/api/v1/invoices/find?status=#{invoice.status}"
    expect(response).to be_success
    raw_invoice = JSON.parse(response.body)
    expect(raw_invoice["status"]).to eq(invoice.status)

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"
    expect(response).to be_success
    raw_invoice = JSON.parse(response.body)
    raw_invoice_created_at = Time.zone.parse(raw_invoice["created_at"]).to_s
    expect(raw_invoice_created_at).to eq(invoice.created_at.to_s)

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"
    expect(response).to be_success
    raw_invoice = JSON.parse(response.body)
    raw_invoice_updated_at = Time.zone.parse(raw_invoice["updated_at"]).to_s
    expect(raw_invoice_updated_at).to eq(invoice.updated_at.to_s)
  end

  it "sends an invoice using a case-insensitive query" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?name=#{invoice.status.upcase}"
    expect(response).to be_success
    raw_invoice = JSON.parse(response.body)
    expect(raw_invoice["status"]).to eq(invoice.status)
  end

  it "sends all invoices with a certain attribute value" do
    invoice1 = create(:invoice, status: "shipped")
    invoice2 = create(:invoice, status: "shipped")

    get '/api/v1/invoices/find_all?status=shipped'
    expect(response).to be_success

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(2)
    expect(invoices.first["status"]).to eq("shipped")
    expect(invoices.last["status"]).to eq("shipped")
  end

  it "sends a random invoice" do
    invoice = create(:invoice)

    get '/api/v1/invoices/random.json'
    expect(response).to be_success
    raw_invoice = JSON.parse(response.body)
    expect(raw_invoice["status"]).to eq(invoice.status)
  end
end
