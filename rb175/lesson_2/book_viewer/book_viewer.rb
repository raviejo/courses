require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

before do
  @toc = File.readlines('data/toc.txt')
end

helpers do
  def in_paragraphs(str)
    result = ""
    @chapter.split("\n\n").each.with_index do |paragraph, idx|
      result << "<p id=\"p#{idx + 1}\">#{paragraph}</p>\n\n"
    end
    result
  end

  def emphasize_match(str, query)
    str.gsub!(Regexp.new(query, Regexp::IGNORECASE), %(<strong>#{query}</strong>))
  end

  def each_chapter
    @toc.each_with_index do |name, idx|
      num = idx + 1
      contents = File.read("data/chp#{num}.txt")
      yield num, name, contents
    end
  end

  def search(query)
    results = []

    return results if !query || query.empty?

    each_chapter do |ch_num, ch_name, ch_contents|
      paragraphs = []
      ch_contents.split("\n\n").each_with_index do |p_content, p_num|
        if p_content.match?(Regexp.new(query, Regexp::IGNORECASE))
          emphasize_match(p_content, query)
          paragraphs << {p_num: p_num, p_content: p_content}
        end
      end
      results << {ch_num: ch_num, ch_name: ch_name, paragraphs: paragraphs} unless paragraphs.empty?
    end

    results
  end
end

not_found do
  redirect "/"
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  erb :home
end

get "/chapters/:num" do
  num = params["num"].to_i
  chapter_name = @toc[num - 1]

  redirect "/" unless (1..@toc.size).cover?(num)

  @title = "Chapter #{num}: #{chapter_name}"
  @chapter = File.read("data/chp#{num}.txt")
  erb :chapter
end

get "/search" do
  @title = "Search"
  @matches = search(params["query"])
  erb :search
end