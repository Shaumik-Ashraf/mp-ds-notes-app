require "test_helper"

class NoteTest < ActiveSupport::TestCase
  test "note with body and user is valid" do
    note = Note.new(body: "Hello", user: users(:alice))
    assert note.valid?
  end

  test "note without body is invalid" do
    note = Note.new(body: "", user: users(:alice))
    assert_not note.valid?
  end

  test "note without user is invalid" do
    note = Note.new(body: "Hello")
    assert_not note.valid?
  end
end
