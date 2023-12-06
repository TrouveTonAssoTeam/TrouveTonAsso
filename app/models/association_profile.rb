class AssociationProfile < ApplicationRecord
  belongs_to :association_reference, class_name: 'Association'
  belongs_to :related_association, foreign_key: 'related_association_id', class_name: 'Association'
  belongs_to :main_association, foreign_key: 'association_id', class_name: 'Association'
end
