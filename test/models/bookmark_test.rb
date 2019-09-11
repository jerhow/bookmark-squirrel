require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  test "valid bookmark" do
    bookmark = bookmarks(:valid)
    assert bookmark.valid?
  end

  test "invalid bookmark missing title" do
    bookmark = bookmarks(:missing_title)
    assert_not bookmark.valid?
  end

  test "invalid bookmark missing url" do
    bookmark = bookmarks(:missing_url)
    assert_not bookmark.valid?
  end

  test "create a bookmark and save it" do
    bookmark = bookmarks(:valid)
    assert bookmark.save!
  end
end
