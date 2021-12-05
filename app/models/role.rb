class Role < ApplicationRecord
  enum name: %i[admin member]
end