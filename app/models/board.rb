class Board < ActiveRecord::Base

    extend FriendlyId
    friendly_id :name, use: :slugged

    validates :name, presence: true, :length => { :minimum => 3 }

    belongs_to :user
    has_and_belongs_to_many :pins
end
