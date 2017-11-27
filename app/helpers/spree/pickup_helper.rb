module Spree::PickupHelper
  def i18n_day_names
    I18n.t('date.day_names').map(&:capitalize)
  end
end
