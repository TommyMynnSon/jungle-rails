module SalesHelper

  def active_sale?
    Sale.active.any?
  end

  def get_active_sale
    Sale.active.first
  end

end