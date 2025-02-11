module Users
  class NotesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_note, only: [:show, :update, :destroy]


    def index
      @notes = current_user.notes
      render json: {data: @notes}, status: :ok
    end

    def show
      @note = current_user.notes.find(params[:id])
      render json: {data: @note}, status: :ok
    end

    def create
      create_service = Notes::CreateService.new(current_user, note_params).call
      if create_service.success?
        render json: {data: create_service.note}, status: :created
      else
        render json: {error: create_service.error}, status: :unprocessable_entity
      end
    end

    def update
      update_service = Notes::UpdateService.new(current_user, params).call
      if update_service.success?
        render json: {data: update_service.note}, status: :ok
      else
        render json: {error: update_service.error}, status: :unprocessable_entity
      end
    end

    def destroy
      @note = current_user.notes.find(params[:id])
      @note.destroy
      render json: {message: "Note deleted successfully"}, status: :no_content
    end

    private

    def note_params
      params.require(:note).permit(:title, :content)
    end

    def set_note
      @note = current_user.notes.find(params[:id])
    end
  end
end