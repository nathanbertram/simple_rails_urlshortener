class ApiAccount < ActiveRecord::Base
  validates_presence_of :key
  validates_presence_of :email

  def self.new_account!(email)
    self.create(:key => ActiveSupport::SecureRandom.hex(20), :email => email)
  end
end