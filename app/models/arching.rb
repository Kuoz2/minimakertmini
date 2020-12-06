class Arching < ApplicationRecord
belongs_to :sale, foreign_key: :sale_id
end
