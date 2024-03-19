class Link < ApplicationRecord
  has_many :views, dependent: :destroy

  validates :url, presence: true
  validates :url, format: { with: URI::regexp, message: 'Invalid url' }

  scope :recent_first, -> { order(created_at: :desc) }

  after_save_commit if: :url_previously_changed? do
    MetadataJob.perform_later(to_param)
  end

  def to_param
    Base62.encode(id)
  end

  def self.find_by_code(code)
    id = Base62.decode(code)
    self.find_by(id: id)
  end

  def domain
    URI(url).host
  end

end
