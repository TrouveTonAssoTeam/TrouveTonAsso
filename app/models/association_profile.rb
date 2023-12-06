class AssociationProfile < ApplicationRecord
  belongs_to :associated_association, class_name: 'Association'
end
