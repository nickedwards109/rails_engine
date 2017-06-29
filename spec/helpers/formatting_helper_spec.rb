require 'rails_helper'
include FormattingHelper

RSpec.describe FormattingHelper do
  it "formats an integer or float into a currency format" do
    float1 = 13
    float2 = 13.0
    float3 = 13.00

    formatted_float_1 = format_to_currency(float1)
    formatted_float_2 = format_to_currency(float2)
    formatted_float_3 = format_to_currency(float2)

    expect(formatted_float_1).to eq("13.00")
    expect(formatted_float_2).to eq("13.00")
    expect(formatted_float_3).to eq("13.00")
  end
end
