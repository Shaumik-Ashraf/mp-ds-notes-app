require "test_helper"

class NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
    @note = @user.notes.create!(body: "Test note body")
    sign_in @user
  end

  test "should get index" do
    get notes_url
    assert_response :success
  end

  test "should get new" do
    get new_note_url
    assert_response :success
  end

  test "should create note" do
    assert_difference("Note.count") do
      post notes_url, params: { note: { body: "New note body" } }
    end
    assert_redirected_to note_url(Note.last)
  end

  test "should show note" do
    get note_url(@note)
    assert_response :success
  end

  test "should get edit" do
    get edit_note_url(@note)
    assert_response :success
  end

  test "should update note" do
    patch note_url(@note), params: { note: { body: "Updated body" } }
    assert_redirected_to note_url(@note)
  end

  test "should destroy note" do
    assert_difference("Note.count", -1) do
      delete note_url(@note)
    end
    assert_redirected_to notes_url
  end

  test "unauthenticated user is redirected to sign in" do
    sign_out @user
    get notes_url
    assert_redirected_to new_user_session_path
  end

  test "user cannot access another user's note" do
    other_user = users(:bob)
    other_note = other_user.notes.create!(body: "Other user's note")
    get note_url(other_note)
    assert_response :not_found
  end
end
