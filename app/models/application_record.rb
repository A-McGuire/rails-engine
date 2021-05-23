class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.all_objects(page_number = 1, per_page = 20)
    page_number = 1 if page_number <= 0
    all.limit(per_page).offset((page_number - 1) * per_page)
  end
end
