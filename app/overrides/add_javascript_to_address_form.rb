Deface::Override.new(
  virtual_path: 'spree/address/_form',
  name: 'add_javascript_to_address_form',
  replace_contents: 'erb[silent]:contains(" if Spree::Config[:address_requires_state] ")',
  closing_selector: 'erb[silent]:contains(" end ")',
  partial: 'spree/address/state'
)