class Promenade < ActiveRecord::Base
  has_many :vantages

  before_validation :replace_address_spaces_with_plus_signs

  protected

  def replace_address_spaces_with_plus_signs
    self.origin_location.gsub!(/\s/, '+')
    self.destination_location.gsub!(/\s/, '+')
  end

end