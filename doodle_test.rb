require 'doodle'
require 'test/unit'
require 'rack/test'

class DoodleTest < Test::Unit::TestCase
  def setup
    @doodle = Doodle.new('test')
    @doodle.reset
  end

  def test_add_question
    @doodle.add_question("Are you sure ?")
    assert_equal [{:question => 'Are you sure ?',
                    :answers => []}], Doodle.new('test').questions
  end

  def test_reset
    @doodle.add_question('Are your sure ?')
    @doodle.reset
    assert !File.exists?('db/test.yml')
    assert_equal [], @doodle.questions
  end
end


set :environment, :test
class DoodleWebTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    @doodle = Doodle.new('test')
    @doodle.add_question('Are you sure ?')
  end

  def test_render_index
    get '/'
    assert last_response.ok?
  end

  def test_render_questions
    get '/'
    assert_match 'Are you sure ?', last_response.body
  end
end
