# sorceror king
class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :email, uniqueness: true,
                    email_format: { message: 'invalid email format' }

  class << self
    # the best solution?
    def current_users
      where("#{sorcery_config.last_activity_at_attribute_name} IS NOT NULL") \
      .where("#{sorcery_config.last_logout_at_attribute_name} IS NULL
        OR #{sorcery_config.last_activity_at_attribute_name} > #{sorcery_config.last_logout_at_attribute_name}") \
      .where("#{sorcery_config.last_activity_at_attribute_name} > ? ", sorcery_config.activity_timeout.seconds.ago.utc.to_s(:db))
    end
  end
end
