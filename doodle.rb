require 'sinatra'
require 'haml'

class Doodle

  attr_reader :questions

  def initialize(env)
    @env = env
    FileUtils.mkdir_p('db')
    FileUtils::touch("db/#{env}.yml")
    @questions = YAML::load_file("db/#{env}.yml") || []
  end

  def add_question(text)
    @questions << {:question => text,
                    :answers=> []}
    write
  end

  def reset
    FileUtils.rm_f "db/#{@env}.yml"
    @questions = []
  end

  private

  def write
    File.open("db/#{@env}.yml", "w") do |f|
      f.write @questions.to_yaml
    end
  end

end

before do
  @doodle = Doodle.new(options.environment.to_s)
end

get '/' do
  @questions = @doodle.questions
  haml :index
end

__END__

@@ index
- unless @questions.empty?
  %ul
    - @questions.each do |question|
      %li= question[:question]
- else
  %p No questions now
%p
  %a{:href => '/new'} Add question
