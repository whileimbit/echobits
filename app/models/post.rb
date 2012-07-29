class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :title
  field :content
  field :created_at, type: Time
  field :updated_at, type: Time
  field :res_count, type: Integer, default: 0

  belongs_to :user
  has_many :responses, :dependent => :delete

  validates :title, presence: true

  before_create :set_created_at

  attr_accessible :title, :content

  scope :active, order_by([[:created_at, :desc]])

  def set_created_at
    self.created_at = Time.now.utc
  end

end
