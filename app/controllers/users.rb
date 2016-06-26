get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect "/"
  else
    @errors = user.errors.full_messages
    erb :'/users/new'
  end
end

get '/users/:id' do
  if current_user && current_user.id == params[:id].to_i
    @questions = current_user.questions
    @quote = User.get_quote
    erb :'/users/show'
  else
    redirect '/login'
  end
end
