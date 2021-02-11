class Project < ApplicationRecord
  enum status: { open: 0, closed: 1 }
end
