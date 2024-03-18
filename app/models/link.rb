class Link < ApplicationRecord
  has_many :views, dependent: :destroy

  validates :url, presence: true
  scope :recent_first, -> { order(created_at: :desc) }

  def to_param
    Base62.encode(id)
  end

  def self.find_by_code(code)
    id = Base62.decode(code)
    self.find_by(id: id)
  end
end
