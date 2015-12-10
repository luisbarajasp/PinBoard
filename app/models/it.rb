class It < ActiveRecord::Base
    belongs_to :pin
    belongs_to :board
end
