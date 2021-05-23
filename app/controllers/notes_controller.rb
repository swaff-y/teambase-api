class NotesController < ApplicationController
  before_action :set_note, only: [:show, :update, :destroy]
  # skip_before_action :verify_authenticity_token

  # GET /notes
  def index
    @notes = Note.all

    render json: @notes
  end

  # GET /notes/1
  def show
    render json: @note
  end

  # POST /notes
  def create
    @note = Note.new(note_params)

    if @note.save
      render json: @note, status: :created, location: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
  end

  def create_note
    note = Note.create(
      note: params[:note]
    )
    Task.find_by(id: params[:task_id]).notes << note
    User.find_by(id: params[:user_id]).notes << note
    render json: {
      success: true
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:user_id, :task_id, :note)
    end
end
