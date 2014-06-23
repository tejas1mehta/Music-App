class Album < ActiveRecord::Base
  validates :name, :band_id, :album_kind, presence: true
  validates :album_kind, inclusion: {in: ["live", "studio"]}

  has_many :tracks, :dependent => :destroy
  belongs_to :band

end
