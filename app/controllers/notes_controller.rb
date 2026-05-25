class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[ show edit update destroy ]

  def index
    @notes = current_user.notes
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    @note = current_user.notes.build(note_params)

    if @note.save
      redirect_to @note, notice: "Note was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @note.update(note_params)
      redirect_to @note, notice: "Note was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @note.destroy!
    redirect_to notes_path, notice: "Note was successfully destroyed.", status: :see_other
  end

  private

  def set_note
    @note = current_user.notes.find(params.expect(:id))
  end

  def note_params
    params.expect(note: [ :body ])
  end
end
