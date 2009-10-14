require 'doodle'
require 'test/unit'
require 'rack/test'

class DoodleTest < Test::Unit::TestCase
  def setup
    @doodle = Doodle.new('test')
  end

  def test_add_question
    @doodle.add_question("Are you sure ?")
    assert_equal ['Are you sure ?' => {}], Doodle.new('test').questions
  end
end


class DoodleWebTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_render_index
    get '/'
    assert last_response.ok?
  end
end
