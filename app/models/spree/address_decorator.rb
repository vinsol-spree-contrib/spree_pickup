Spree::Address.class_eval do

  attr_accessor :name_not_require

  _validators.except!(:firstname, :lastname)
  validators.first.instance_variable_set(:@attributes, validators.first.instance_variable_get(:@attributes)- [:firstname, :lastname])

  validates :firstname, :lastname, presence: true, unless: :name_not_require

end

