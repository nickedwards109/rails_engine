module FormattingHelper
  def format_to_currency(float)
    if float.to_s.split(".").length == 1
      formatted_string = float.to_s + ".00"
    elsif float.to_s.split(".").last.length == 1
      formatted_string = float.to_s + "0"
    else
      formatted_string = float.to_s
    end
    formatted_string
  end
end
