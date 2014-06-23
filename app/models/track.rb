class Track < ActiveRecord::Base
  validates :name, :album_id, :track_kind, presence: true
  validates :track_kind, inclusion: {in: ["bonus", "regular track"]}

  belongs_to :album

  has_one :band, through: :album, source: :band

  has_many :notes, class_name: "Note", foreign_key: :track_id, primary_key: :id, :dependent => :destroy

end
