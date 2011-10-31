before do
  @title = @@conf['title']
end

get '/' do
  haml :index
end

