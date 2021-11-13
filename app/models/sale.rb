class Sale < ActiveRecord::Base

  # AR Scope ()
  # scope :active, -> { where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current) }  

  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !finished? && !upcoming?
  end

end
