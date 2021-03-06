class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Token

  field :title
  field :content
  field :created_at, type: Time
  field :updated_at, type: Time
  field :actived_at, type: Time
  field :res_count, type: Integer, default: 0

  token :length => 8

  belongs_to :user
  has_many :responses, :dependent => :delete

  validates :title, presence: true

  before_create :set_created_at

  attr_accessible :title, :content

  scope :active, order_by([[:actived_at, :desc]])

  def set_created_at
    self.created_at = Time.now.utc
    self.actived_at = self.created_at
  end
end
