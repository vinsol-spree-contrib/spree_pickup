Spree::Stock::Estimator.class_eval do

  def shipping_methods(package, display_filter)
    package.shipping_methods.select do |ship_method|
      calculator = ship_method.calculator
      begin
        ship_method.available_to_display(display_filter) && ship_method.pickupable &&
        ship_method.include?(order.ship_address || order.pickup_address ) &&
        calculator.available?(package) &&
        (calculator.preferences[:currency].blank? ||
         calculator.preferences[:currency] == currency)
      rescue Exception => exception
        log_calculator_exception(ship_method, exception)
      end
    end
  end

end
