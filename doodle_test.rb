require 'doodle'
require 'test/unit'

class DoodleTest < Test::Unit::TestCase
  def setup
    @doodle = Doodle.new('test')
  end

  def test_add_question
    @doodle.add_question("Are you sure ?")
    assert_equal ['Are you sure ?' => {}], Doodle.new('test').questions
  end
end
