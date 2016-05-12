# this serves the index page with all questions
get '/questions' do
  @questions = Question.all
  erb :'questions/index'
end

# this serves a form to post a new question
get '/questions/new' do
  erb :'questions/new'
end

# this handles saving the new question
post '/questions' do
  @question = Question.new( params[:question] )
  if @question.save
    redirect '/questions'
  else
    # test error handling
    @errors = @question.errors.full_messages
    erb :'questions/new'
  end
end

# this shows a specific question on a show page
get '/questions/:id' do
  @question = Question.find_by( id: params[ :id ] )
  erb :'questions/show'
end

# this serves a specific question for editing
get '/questions/:id/edit' do
  @question = Question.find_by( id: params[ :id ] )
  erb :'questions/edit'
end

# this handles saving and posting the edited question
put 'questions/:id' do
  @question = Question.find_by( id: params[ :id ] )
  @question.assign_attributes( params[ :question ] )
  if @question.save
    redirect "/questions/<%= @question.id %>"
  else
    # test error handling
    @errors = @question.errors.full_messages
    erb :'questions/edit'
  end
end

# this destroys the question from the database
delete 'questions/:id' do
  question = Question.find_by( id: params[ :id ] )
  question.destroy
  redirect '/questions'
end