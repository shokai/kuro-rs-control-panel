before do
  @title = @@conf['title']
end

before '*.json' do
  content_type = 'application/json'
end

get '/' do
  haml :index
end

get '/kuro-rs.json' do
  uri = URI.parse kuro_rs_server
  res = Net::HTTP.start(uri.host, uri.port).get(uri.path)
  unless res.code == '200'
    status 500
    @mes = {:err => res.body}.to_json
  else
    status 200
    @mes = {:data => res.body}.to_json
  end
end

post '/kuro-rs.json' do
  data = params[:data]
  uri = URI.parse kuro_rs_server
  res = Net::HTTP.start(uri.host, uri.port).post(uri.path, data)
  unless res.code == '200'
    status 500
    @mes = {:err => res.body}.to_json
  else
    status 200
    @mes = {:msg => res.body}.to_json
  end
end

get '/ir/:name.json' do
  @ir_name = params[:name]
  @ir = IR.where(:name => @ir_name).first rescue @ir = nil
  if @ir
    @ir.to_hash.to_json
  else
    {:error => 'not found'}.to_json
  end
end

post '/ir/:name.json' do
  @ir_name = params[:name]
end

get '/ir/:name' do
  @title = "#{@title} - IR:#{params[:name]}"
  haml :ir
end
