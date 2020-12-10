class StarwarsController < ApplicationController

  # GET: /stories - get or see all starwars
  get "/starwars" do # request info to see and display it
    redirect_if_not_logged_in
    @starwars = Starwar.all
    erb :"/starwars/index" 
  end
  
  # GET: /starwars/new - get the form to create a new starwar (does not create)
  get "/starwars/new" do 
    redirect_if_not_logged_in
    erb :"/starwars/new" 
  end

  # POST: /starwars - form is submitted here - CREATES new starwar from form data
  post "/starwars" do 
    redirect_if_not_logged_in
    # if .value.empty? replace with 
    # faker_hash
    binding.pry
    starwar = Starwar.new(params)
    
    starwar.user_id = session[:user_id] # not a @var because we're going to redirect and lose this data anyway
    #faker
    
    starwar.save 
    #@@madlibs << starwar
    #flash[:message] = "Story saved!"
    redirect "/starwars/#{starwar.id}" # makes a new GET request - sending info to server to do something with it
  end
  
  # GET: /starwars/5 - get one specific starwar
  get "/starwars/:id" do 
    @starwar = Starwar.find(params[:id]) #or "id"
    #@starwar.update(title: params["starwar"]["title"])
    erb :"/starwars/show"
  end

  # GET: /starwars/5/edit - get the form to edit a specific starwar...
  get "/starwars/:id/edit" do 
    @starwar = Starwar.find(params["id"]) 
    # the above line of code should be in every route that has :id
    redirect_if_not_authorized 
    erb :"/starwars/edit"
  end

  # PATCH: /starwars/5 - ...and update that specific starwar using patch/put
  patch "/starwars/:id" do # put/patch
    redirect_if_not_logged_in
    @starwar = Starwar.find(params["id"])
    redirect_if_not_authorized
    #binding.pry
    @starwar.update(params["starwars"])
    
    flash[:message] = "Edit successful."
    redirect "/starwars/#{@starwar.id}"

    #@starwar.update[title]
    #@starwar.update(title: params["starwar"]["title"])
    #
    #@starwar_array = @starwar.update(params["starwars"]) # ???
    
    
    # @starwar = Starwar.find(params["id"])
    # @replace = params[:starwars]
    # @replace.transform_values do |value| 
    #   if value == nil
    #       value = "BLANK"
    #   else 
    #     value = value
    #   end
    # end
    # @starwar.update(@replace)
    #@starwar_hash = @starwar_array.as_json
    #@starwar_hash.merge!(@faker_hash)

    #faker method ?
  end

  # DELETE: /starwars/5/delete - destroy a starwar from the database
  delete "/starwars/:id" do 
    starwar = Starwar.find(params["id"])
    #redirect_if_not_authorized
    starwar.destroy
    flash[:message] = "Story deleted."
    #show success message
    redirect "/users"
  end

  private

  def redirect_if_not_authorized
    if @starwar.user_id != session[:user_id]
      flash[:message] = "Error. Please try again."
      redirect "/starwars"  
    end
  end

  #faker_hash

#   def faker
#     params.each do |value|
#       if value.empty?
#         @faker_array.each do |k, v|
#           v = value
#         end
#       end
#     end
#   end


#   @faker_array[0] = params[0]
# params[:noun_1] = "h"
# params.each do |key,value|
#   sql = "INSERT INTO starwars (key) VALUES (value)"

end






