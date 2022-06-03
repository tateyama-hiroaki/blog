require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:first_article)
  end

  teardown do
    Rails.cache.clear
  end

  test "index page layout" do
    get "/"
    assert_select "h1", text: "Articles"
    assert_select "ul" do
      assert_select "li"
      assert_select "a[href=?]", "/articles/#{@article.id}", text: "#{@article.title}" 
    end
    assert_select "a[href=?]", "/articles/new", text: "New Article"
  end

  test "show page layout" do
    get "/articles/#{@article.id}"
    assert_select "h1", text: "#{@article.title}"
    assert_select "p", text: "#{@article.body}"
    assert_select "ul" do
      assert_select "li", count: 2
      assert_select "a[href=?]", "/articles/#{@article.id}/edit", text: "Edit"
      assert_select "a[href=?]", "/articles/#{@article.id}", text: "Destroy"
    end
  end

  test "new page layout" do
    get "/articles/new"
    assert_select "h1", text: "New Article"
    assert_select "form", action: "/articles", method: "post" do
      assert_select "label", text: "Title"
      assert_select "label", text: "Body"
      assert_select "label", text: "Status"
      assert_select "select"
      assert_select "input", value: "Create Article"
    end
  end

  test "edit page layout" do
    get "/articles/#{@article.id}/edit"
    assert_select "h1", text: "Edit Article"
    assert_select "form", action: "/articles/#{@article.id}", method: "post" do
      assert_select "label", text: "Title"
      assert_select "label", text: "Body"
      assert_select "label", text: "Status"
      assert_select "select"
      assert_select "input", value: "Create Article"
    end
  end
end