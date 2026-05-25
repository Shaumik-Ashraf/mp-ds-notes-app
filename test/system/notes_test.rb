require "application_system_test_case"

class NotesTest < ApplicationSystemTestCase
  test "full lifecycle with sign in and sign out" do
    user = users(:alice)

    # --- Sign in ---
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password123"
    click_button "Log in"

    assert_text "Notes"

    # --- Create note ---
    click_on "New note"
    fill_in "Body", with: "Meeting notes for Q1"
    click_button "Create Note"

    assert_text "Note was successfully created."
    assert_text "Meeting notes for Q1"

    # --- Sign out ---
    click_on "Sign out"
    assert_selector "input[type=email]"

    # --- Sign back in ---
    fill_in "Email", with: user.email
    fill_in "Password", with: "password123"
    click_button "Log in"

    assert_text "Notes"

    # --- Read the note ---
    click_on "Meeting notes for Q1"
    assert_text "Meeting notes for Q1"

    # --- Update the note ---
    click_on "Edit"
    fill_in "Body", with: "Updated meeting notes for Q2"
    click_button "Update Note"

    assert_text "Note was successfully updated."
    assert_text "Updated meeting notes for Q2"

    # --- Sign out ---
    click_on "Sign out"
    assert_selector "input[type=email]"

    # --- Sign back in ---
    fill_in "Email", with: user.email
    fill_in "Password", with: "password123"
    click_button "Log in"

    assert_text "Notes"

    # --- Delete the note ---
    click_on "Updated meeting notes for Q2"
    accept_confirm "Delete this note?" do
      click_on "Delete"
    end

    assert_text "Note was successfully destroyed."
    assert_text "No notes yet."

    # --- Sign out ---
    click_on "Sign out"
    assert_selector "input[type=email]"
  end
end
