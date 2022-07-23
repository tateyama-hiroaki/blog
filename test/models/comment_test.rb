require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    article = articles(:first_article)
    @comment = article.comments.build(commenter: "Bob", body: "Hello, Ruby on Rails.", status: "public")
  end

  def teardown
    Rails.cache.clear
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "commenter should be present" do
    @comment.commenter = " "
    assert_not @comment.valid?
  end

  test "body should be present" do
    @comment.body = " "
    assert_not @comment.valid?
  end

  test "body should not be too long" do
    @comment.body = "s" * 141
    assert_not @comment.valid?
  end
end