class Pin < ActiveRecord::Base

    extend FriendlyId
    friendly_id :title, use: :slugged

    belongs_to :user

    has_attached_file :image, styles: { medium: "250x", thumb: "100x100>" }, default_url: "defaultImage.png"
		validates_attachment_content_type :image, content_type: %w(image/jpeg image/jpg image/png)

    validates :title, :image, presence: true

end
