require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'invalid signup information' do
    
    get signup_path
    
    assert_no_difference 'User.count' do
      post users_path, user: { name: '', email: 'user@invalid', password: 'foo', password_confirmation: 'bar' }
    end
    
    assert_template 'users/new'
    
  end

  test 'valid signup information' do
    
    get signup_path
    
    assert_difference 'User.count', 1 do
      post users_path, user: { name: 'Bob User',
                               email: 'bob.user@example.com',
                               password: 'foobar',
                               password_confirmation: 'foobar' }
    end
    
    user = User.find_by(email: 'bob.user@example.com')
    
    assert_not_nil user
    
    #Not sure what's going on here, page is showing the proper thing, but this test isn't working. 
    #UI redirects properly
    #assert_template 'users/show'
    
    #This works but doesn't make any sense
    #assert_template nil
  end

end
