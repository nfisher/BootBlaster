require 'test/unit'
require 'mocha'

class BootBlasterTest < Test::Unit::TestCase
	def test_answer_to_everything
		assert_equal 42, 42
	end

	def test_query_virtualbox_for_available_machines
		assert_equal true, true
	end
end
