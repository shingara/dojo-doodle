require 'sinatra'

class Doodle

  attr_reader :questions

  def initialize(env)
    @env = env
    FileUtils.mkdir_p('db')
    FileUtils::touch("db/#{env}.yml")
    @questions = YAML::load_file("db/#{env}.yml") || []
  end

  def add_question(text)
    @questions << {text => {}}
    write
  end

  private

  def write
    File.open("db/#{@env}.yml", "w") do |f|
      f.write @questions.to_yaml
    end
  end

end

get '/' do
  'ok'
end
