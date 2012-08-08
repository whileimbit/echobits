class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  field :login, type: String
  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :access_token, type: String
  field :created_at, type: Time

  has_secure_password

  validates :login, :email, :presence => true, :uniqueness => {:case_sensitive => false}
  validates :login, :format => {:with => /\A\w+\z/, :message => 'only A-Z, a-z, _ allowed'}, :length => {:in => 3..20} 
  validates :email, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}, :uniqueness => {:case_sensitive => false}
  validates :password, :presence => true, :on => :create
  validates :password, confirmation: true, :length => {:minimum => 6, :allow_nil => true}

  before_create :set_created_at

  attr_accessible :login, :name, :email, :password, :password_confirmation

  has_many :posts
  has_many :responses

  scope :active, order_by([[:created_at, :desc]])

  def to_param
    login
  end

  def set_created_at
    self.created_at = Time.now.utc
  end

  def admin?
    APP_CONFIG['admin_emails'].include?(self.email)
  end

end
