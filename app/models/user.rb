class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  # def login=(login)
  #   @login = login
  # end

  # def login
  #   @login || self.username || self.email
  # end

  has_attached_file :avatar,
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials },
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "https://s3.amazonaws.com/predikt-app/missing.jpg"

  validates_attachment_content_type :avatar, 
                                    :content_type => /\Aimage\/.*\Z/

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }


  def s3_credentials
    {
      :bucket => ENV['S3_BUCKET'],
      :access_key_id => ENV['S3_ACCESS_KEY_ID'],
      :secret_access_key => ENV['S3_SECRET_ACCESS_KEY']
    }
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  # def country_name
  #   country = ISO3166::Country[address_country]
  #   country.translations[I18n.locale.to_s] || country.name
  # end
  
end
