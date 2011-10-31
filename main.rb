before do
  @title = @@conf['title']
end

before '*.json' do
  content_type = 'application/json'
end

get '/' do
  @irs = IR.all.asc(:name)
  haml :index
end

get '/list.json' do
  IR.all.asc(:name).map{|ir| ir.to_hash}.to_json
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
  ir_name = params[:name]
  ir = IR.where(:name => ir_name).first rescue ir = nil
  if ir
    status 200
    ir.to_hash.to_json
  else
    status 404
    {:err => 'not found'}.to_json
  end
end

post '/ir/:name.json' do
  ir_name = params[:name]
  data = params['data']
  ir = IR.where(:name => ir_name).first rescue ir = nil
  ir = IR.new(:name => ir_name) unless ir
  ir.data = data
  begin
    ir.save
    status 200
    @mes = ir.to_hash.to_json
  rescue => e
    status 500
    @mes = {:err => e.to_s}.to_json
  end
end

get '/ir/:name' do
  ir_name = params[:name]
  @ir = IR.where(:name => ir_name).first rescue @ir = nil
  @ir = IR.new(:name => ir_name) unless @ir
  haml :ir
end
