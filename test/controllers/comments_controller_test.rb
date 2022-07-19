require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @article = articles(:first)
    @comment = @article.comments.create(commenter: "Bob", body: "Hello, Ruby on Rails.", status: "public")
  end

  def teardown
    Rails.cache.clear
  end

  test "Did you succeed in creating a comment?" do
    assert_difference("@article.comments.count") do
      post article_comments_url(@article), params: { comment: { commenter: "Alice", body: "Hello, Ruby.", status: "public" } }
    end 

    assert_redirected_to @article
  end

  test "Did you succeed in destroy a comment?" do
    assert_difference("@article.comments.count", -1) do
      delete article_comment_url(@article, @comment)
    end

    assert_redirected_to @article
  end
end