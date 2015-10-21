require 'test_helper'
require 'generators/chucky_scaff/chucky_scaff_generator'

class ChuckyScaffGeneratorTest < Rails::Generators::TestCase
  tests ChuckyScaffGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
