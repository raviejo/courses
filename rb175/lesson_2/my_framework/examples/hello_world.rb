# hello_world.rb

require_relative "advice.rb"
require "erb"

class HelloWorld
  def call(env)
    html = env.each_with_object("") do |pair, str|
      key, value = pair
      str << "<li>#{key}: #{value}</li>"
    end
    html = "<ul style=\"font-size: 10\">#{html}</ul><br>"

    case env["REQUEST_PATH"]
    when "/"
      template = File.read('views/index.erb')
      content = ERB.new(template)
      ["200", {"Content-Type" => "text/html"}, [html + "<html><body><h2>Hello World!</h2></body></html>"]]
    when "/advice"
      piece_of_advice = Advice.new.generate
      ["200", {"Content-Type" => "text/html"}, [html + "<html><body><em><b>#{piece_of_advice}</em></b></body></html>"]]
    else
      [
        "404",
        {
          "Content-Type" => "text/html",
          "Content-Length" => "<html><body>#{html}<h4>404 Not Found</h4></body></html>".chars.size.to_s,
        },
        [html + "<html><body>#{html}<h4>404 Not Found</h4></body></html>"]
      ]
    end
  end
end