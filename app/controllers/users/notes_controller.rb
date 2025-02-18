module Users
  class NotesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_note, only: [:show, :update, :destroy]


    def index
      @notes = current_user.notes
      render json: {notes: @notes}, status: :ok
    end

    def show
      @note = current_user.notes.find(params[:id])
      render json: {note: @note}, status: :ok
    end

    def create
      create_service = Notes::CreateService.new(current_user, note_params).call
      if create_service.success?
        render json: {note: create_service.note}, status: :created
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
      if @note.destroy
        render json: {}, status: :no_content
      else
        render json: {error: "Erro ao deletar nota. Tente novamente."}, status: :unprocessable_entity
      end
    end

    private

    def note_params
      params.require(:note).permit(:title, :content)
    end

    def set_note
      begin
        @note = current_user.notes.find(params[:id])
      rescue Mongoid::Errors::DocumentNotFound
        @note = nil
        render json: {error: "Nota não encontrada."}, status: :not_found
      end
    end
  end
end