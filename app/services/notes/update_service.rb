module Notes
  class UpdateService < BaseService
    attr_reader :user, :params

    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      begin
        note = user.notes.find(params[:id])
        
        if note.update(note_params)
          @success = true
          @note = note
          self
        else
          add_error("Erro ao atualizar nota. Tente novamente.")
          self
        end
      rescue ActiveRecord::RecordNotFound
        add_error("Nota não encontrada.")
        self
      end
    end

    def note  
      @note
    end

    private

    def note_params
      params.require(:note).permit(:title, :content)
    end
  end
end