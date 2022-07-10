require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = articles(:first_article)
  end

  def teardown
    Rails.cache.clear
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "title should be present" do
    @article.title = " "
    assert_not @article.valid?
  end

  test "body should be present" do
    @article.body = " "
    assert_not @article.valid?
  end

  test "body should not be too short" do
    @article.body = "s" * 3
    assert_not @article.valid?
  end
end