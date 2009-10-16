### APPLICATION ###

require 'sinatra'

class Doodle
  
  attr_reader :questions

  def initialize
    FileUtils.touch('test.yml')
    @questions = YAML::load_file('test.yml') || []
  end
 def add_question(text)
   @questions << text
   File.open('test.yml', 'w') do |f|
     f.write @questions.to_yaml
   end
 end 

 def self.reset
   FileUtils.rm_f('test.yml')
 end

end

get '/' do
  d = Doodle.new
  if d.questions.empty?
    'No Question'
  else
    d.questions.first
  end
end

post '/' do
  d = Doodle.new
  d.add_question(params[:text])
end

get '/:index' do
  d = Doodle.new
  if d.questions.size >= params[:index].to_i
    d.questions[params[:index]]
  else
    not_found
  end
end
