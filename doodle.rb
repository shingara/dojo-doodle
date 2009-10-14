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

  def reset
    FileUtils.rm_f "db/#{@env}.yml"
  end

  private

  def write
    File.open("db/#{@env}.yml", "w") do |f|
      f.write @questions.to_yaml
    end
  end

end

configure :test do
  @doodle = Doodle.new('test')
end

get '/' do
  @questions = @doodle.questions
  haml :index
end

__END__

@index
#ul
  - @questions.each do |question|
    %li= question.key
