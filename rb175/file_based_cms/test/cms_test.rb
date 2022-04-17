ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'fileutils'

require_relative '../cms'

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    # Create a directory for test files
    FileUtils.mkdir_p(data_path)
  end

  def teardown
    # Remove the test data path
    FileUtils.rm_rf(data_path)
    session.delete(:username)
  end

  def create_document(name, content='')
    File.open(File.join(data_path, name), 'w') do |file|
      file.write(content)
    end
  end

  def session
    last_request.env['rack.session']
  end

  def admin_session
    { 'rack.session' => { username: 'admin' } }
  end

  def test_index
    # post '/users/signin', username: 'admin', password: 'secret'

    create_document 'about.md'
    create_document 'changes.txt'

    get '/', {}, admin_session

    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, 'about.md'
    assert_includes last_response.body, 'changes.txt'
  end

  def test_text_file
    create_document 'changes.txt', 'These are some changes'
    create_document 'history.txt', 'We are making history!'

    get '/changes.txt', {}, admin_session

    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    assert_equal 'These are some changes', last_response.body

    get '/history.txt', {}, admin_session
    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    assert_equal 'We are making history!', last_response.body
  end

  def test_file_does_not_exist
    get '/ricky.txt', {}, admin_session # Attempt to access a nonexistent file

    assert_equal 'ricky.txt does not exist.', session[:message]

    # assert_equal 302, last_response.status # Assert that the user was redirected

    # get last_response['Location'] # Request the page that the user was redirected to

    # assert_equal 200, last_response.status
    # assert_includes last_response.body, 'ricky.txt does not exist.'

    # get '/'
    # refute_includes last_response.body, 'ricky.txt does not exist'
  end

  def test_markdown_file
    create_document 'about.md', '<h1>Ruby is...</h1>A dynamic, open source programming language'

    get '/about.md', {}, admin_session # Access a markdown file

    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, '<h1>Ruby is...</h1>'
    assert_includes last_response.body, 'A dynamic, open source programming language'
  end

  def test_editing_document
    create_document 'about.md'

    get '/about.md/edit', {}, admin_session

    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, '<textarea'
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_editing_document_signed_out
    create_document 'about.md'

    get '/about.md/edit'

    assert_equal 302, last_response.status
    assert_includes 'You must be signed in to do that.', session[:message]
  end

  def test_updating_document
    create_document 'test_file.txt'

    post '/test_file.txt/edit', { content: 'About ruby' }, admin_session

    assert_equal 302, last_response.status
    assert_equal 'test_file.txt has been updated.', session[:message]

    # get last_response['Location']
    # assert_includes last_response.body, 'test_file.txt has been updated'

    get '/test_file.txt', {}, admin_session
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'About ruby'
  end

  def test_updating_document_signed_out
    create_document 'test_file.txt'

    post '/test_file.txt/edit'

    assert_equal 302, last_response.status
    assert_includes 'You must be signed in to do that.', session[:message]
  end

  def test_new_document_form
    get '/create', {}, admin_session

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_new_document_form_signed_out
    get '/create'

    assert_equal 302, last_response.status
    assert_includes 'You must be signed in to do that.', session[:message]
  end

  def test_create_new_document
    # post '/users/signin', username: 'admin', password: 'secret'
    # assert session[:signed_in]

    post '/create', { file_name: 'hello_there.txt' }, admin_session
    assert_equal 302, last_response.status
    assert_equal 'hello_there.txt was created.', session[:message]

    # get last_response['Location']
    # assert_includes last_response.body, 'hello_there.txt was created.'

    get '/', {}, admin_session
    assert_includes last_response.body, 'hello_there.txt'
  end

  def test_create_new_document_signed_out
    post '/create', { file_name: 'hello_there.txt' }

    assert_equal 302, last_response.status
    assert_includes 'You must be signed in to do that.', session[:message]
  end

  def test_create_new_document_without_filename
    post '/create', { file_name: '' }, admin_session

    assert_equal 422, last_response.status
    assert_includes last_response.body, 'A name is required.'
  end

  def test_create_new_document_without_extension
    post '/create', { file_name: 'hello' }, admin_session
    # assert_equal 'A valid extension name needs to be provided.', session[:message]

    assert_equal 422, last_response.status
    assert_includes last_response.body, 'A valid extension name needs to be provided.'
  end

  def test_delete_file
    create_document 'test_file.md'

    post '/test_file.md/destroy', {}, admin_session
    assert_equal 302, last_response.status
    assert_equal 'test_file.md has been deleted.', session[:message]


    # get last_response['Location']
    # assert_equal 200, last_response.status
    # assert_includes last_response.body, 'test_file.md has been deleted.'

    get '/'
    refute_includes last_response.body, %q(href="/test.txt")
  end

  def test_delete_file_signed_out
    create_document 'test_file.md'

    post '/test_file.md/destroy'

    assert_equal 302, last_response.status
    assert_equal 'You must be signed in to do that.', session[:message]
  end

  def test_index_signed_out_user
    get '/'

    assert_equal 200, last_response.status
    assert_includes last_response.body, %q(<button type="submit")
    assert_includes last_response.body, '<form'
  end

  def test_index_signed_in_user
    post '/users/signin', username: 'admin', password: 'secret'

    # post '/users/signin', {}, admin_session

    assert_equal 302, last_response.status
    assert_equal 'Welcome!', session[:message]
    assert_equal 'admin', session[:username]

    # get last_response['Location']
    # assert_equal 200, last_response.status
    # assert_includes last_response.body, 'Signed in as admin.'
    # assert_includes last_response.body, 'You have been signed out.'
  end

  def test_invalid_credentials
    post '/users/signin', username: 'admin', password: 'shhh'
    # assert_equal 'Invalid Credentials', session[:message]

    assert_equal 422, last_response.status
    assert_includes last_response.body, 'Invalid Credentials'
  end

  def test_sign_in_page
    get 'users/signin'

    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Username:'
    assert_includes last_response.body, 'Password:'
  end

  def test_sign_out
    # post '/users/signin', username: 'admin', password: 'secret'
    # assert_equal 'Welcome!', session[:message]

    get '/', {}, admin_session
    assert_includes last_response.body, 'Signed in as admin'
    # get last_response["Location"]
    # assert_includes last_response.body, "Welcome"

    post '/users/signout'
    assert_equal 'You have been signed out.', session[:message]

    get last_response['Location']
    assert_nil session[:username]
    assert_includes last_response.body, 'Sign In'

    # assert_includes last_response.body, 'You have been signed out'
  end
end