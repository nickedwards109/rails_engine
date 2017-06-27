class Item < ApplicationRecord
  def self.find_case_insensitive(item_params)
    if item_params[:name]
      Item.find_by("name ILIKE ?", item_params[:name])
    elsif item_params[:description]
      Item.find_by("description ILIKE ?", item_params[:description])
    else
      Item.find_by(item_params)
    end
  end

  def self.find_all_case_insensitive(item_params)
    if item_params[:name]
      Item.where("name ILIKE ?", item_params[:name])
    elsif item_params[:description]
      Item.where("description ILIKE ?", item_params[:description])
    else
      Item.where(item_params)
    end
  end
end
