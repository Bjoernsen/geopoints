class Point
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid
  
  field :coordinates, type: Array    # [N, E] [latitude, longitude] --> 9.822864, 51.650772
  field :address
  #belongs_to :type

  validates :address, :coordinates, presence: true
  
  index({ coordinates: '2d' }, { min: -180, max: 180 })
  
  geocoded_by :address
  
  reverse_geocoded_by :coordinates
    
  before_validation :geocode_all
  
  def geocode_all
    # TODO: TEST
    # TODO: YARD
    if address.present? && coordinates.blank?
      geocode
    elsif address.blank? && coordinates.present?
      reverse_geocode
    end
  end
  
  private
  
  
end