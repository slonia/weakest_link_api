class Question < ApplicationRecord
  belongs_to :bunch, optional: true
end
