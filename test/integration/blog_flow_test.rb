require "test_helper"

class BlogFlowTest < ActionDispatch::IntegrationTest
  test "can create an article" do
    get "/articles/new"
    assert_response :success

    # 記事の作成
    post "/articles", params: { article: { title: "can create", body: "article successfully.", status: "public" } }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    # 記事の参照
    assert_select "h1", text: "can create"

    # 記事の更新
    patch "/articles/#{Article.last.id}", params: { article: { title: "hello" } }
    assert_redirected_to article_url(Article.last.id)
    article = Article.last
    article.reload
    assert_equal "hello", article.title

    # 記事の削除
    delete "/articles/#{Article.last.id}"
    assert_redirected_to root_url
  end
end