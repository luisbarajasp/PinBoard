class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_attached_file :avatar, styles: { medium: "200x200", thumb: "100x100>", mini: "30x30>" }, default_url: "defaultImage.png"
  validates_attachment_content_type :avatar, content_type: %w(image/jpeg image/jpg image/png)

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :pins, dependent: :destroy
  has_many :boards, dependent: :destroy

  acts_as_voter

  acts_as_follower

  acts_as_followable

end
