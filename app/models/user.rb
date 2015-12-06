class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_attached_file :avatar, styles: { medium: "200x200", thumb: "100x100>", mini: "30x30>" }, default_url: "defaultImage.png"
		validates_attachment_content_type :avatar, content_type: %w(image/jpeg image/jpg image/png)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins, dependent: :destroy
end
