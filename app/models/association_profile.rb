class AssociationProfile < ApplicationRecord
  belongs_to :association_reference, class_name: 'Association'
  belongs_to :related_association, foreign_key: 'association', class_name: 'Association'
end
