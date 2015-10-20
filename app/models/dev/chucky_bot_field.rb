class ChuckyBotField < ActiveRecord::Base
  serialize :formats_options, Hash
  serialize :validations_options, Hash
  serialize :association_options, Hash
  belongs_to :chucky_bot
end
