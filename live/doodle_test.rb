### TEST ###

require 'doodle'
require 'test/unit'
require 'rack/test'

class DoodleWebTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    Doodle.reset
  end

  def test_index
    get '/'
    assert last_response.ok?
  end

  def test_render_no_question
    get '/'
    assert_match 'No Question', last_response.body
  end

  def test_post_question
    post '/', :text => 'ok'
    assert last_response.ok?
  end

  def test_view_question_after_post
    post '/', :text => 'ok'
    get '/'
    assert_match 'ok', last_response.body
  end

  def test_show_question
    post '/', :text => 'ok'
    get '/1'
    assert_match 'ok', last_response.body
  end

  def test_render_404
    post '/', :text => 'ok'
    get '/2'
    assert_equal 404, last_response.status
  end

end

class DoodleTest < Test::Unit::TestCase
  def setup
    Doodle.reset
  end

  def test_add_question
    d = Doodle.new
    d.add_question('ok')
    assert_equal ['ok'], d.questions
  end
end

