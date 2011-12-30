require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :first_name, :last_name, :middle_name, :email, :password, :password_confirmation, :screen_name
    has_many :products, :dependent => :destroy
	has_many :productpurchases, :dependent => :destroy
	has_many :userpoints, :dependent => :destroy
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  	validates :screen_name,  :presence => true,
                    :length   => { :maximum => 50 }
 	validates :first_name,  :presence => true,
                    :length   => { :maximum => 50 }
 	validates :last_name,  :presence => true,
                    :length   => { :maximum => 50 }
 	validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
    validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 },
                       :on => :create
	before_save :encrypt_password

	def has_password?(submitted_password)
   	 encrypted_password == encrypt(submitted_password)
  	end
  	
	def self.authenticate(email, submitted_password)
    	user = find_by_email(email)
    	return nil  if user.nil?
    	return user if user.has_password?(submitted_password)
 	end

	def score
		97.4
	end
	
	after_save :create_userpoints

  private

	def create_userpoints
		userpoint = Userpoint.create(:user_id => self.id, :points => 200)
		userpoint.save
	end

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

	

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
    def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
    
end
