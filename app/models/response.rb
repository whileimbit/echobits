class Response
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :content
  field :created_at, type: Time

  belongs_to :user
  belongs_to :post

  validates :content, :presence => true

  before_create :set_created_at
  after_create :update_post

  attr_accessible :content

  scope :latest, order_by([[:created_at, :desc]])
  scope :recent, order_by([[:created_at, :desc]]).limit(10)

  def update_post
    post.set :actived_at, self.created_at.utc
    post.inc :res_count, 1
  end

  def set_created_at
    self.created_at = Time.now.utc
  end
end
