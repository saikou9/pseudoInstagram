require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                      password: "testtest", password_confirmation: "testtest")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "name lenth should be less 50 symbols" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "email lenth should be less 50 symbols" do
    @user.email = "a" * 51 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    vaild_adresses = %w[user@example.com max@gmail.com sobolev@mail.ru g545@yandex.ru 78342hfyre3G63@yahoo.com]

    vaild_adresses.each do |valid_adress|
      @user.email = valid_adress
      assert @user.valid?
    end
  end

  test "email validation should decline valid addresses" do
    vaild_adresses = %w[userd*9 GamGEaw sobolev@ SaSSsS @yahoo.com]

    vaild_adresses.each do |valid_adress|
      @user.email = valid_adress
      assert_not @user.valid?
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "" * 3
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.invalid?
  end
  

end