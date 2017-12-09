Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'add_pick_up_location_in_configuration',
  insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
  text: '<%= configurations_sidebar_menu_item Spree.t(:pickup_locations), '\
        'spree.admin_pickup_locations_path %>',
  original: '28204a1f46d26e6579991e4e85b67317e50458d5'
)
