require "socket"

server = TCPServer.new("localhost", 3003)

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split
  path, params = path_and_params.split("?")

  params = (params || "").split("&").each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end

  [http_method, path, params]
end

loop do
  client = server.accept
  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  http_method, path, params = parse_request(request_line)

  number = params["number"].to_i

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"
  client.puts "<html>"
  client.puts "<body>"

  client.puts "<pre>"
  client.puts "Request Line: #{request_line}"
  client.puts "Method: #{http_method}"
  client.puts "Path: #{path}"
  client.puts "Params: #{params}"
  client.puts "</pre>"

  client.puts "<h1>Live Counter!</h1>"
  client.puts "<p>The current nuber is #{number}.</p>"
  client.puts "<p>Increase the counter: <a href='?number=#{number+1}'>Increase</a></p>"
  client.puts "<p>Decrease the counter: <a href='?number=#{number-1}'>Decrease</a></p>"

  client.puts "</body>"
  client.puts "</html>"

  client.close
end