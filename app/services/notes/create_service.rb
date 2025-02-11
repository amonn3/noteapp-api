module Notes
  class CreateService < BaseService
    attr_reader :user, :params

    def initialize(user, params)
      @user = user
      @params = params
    end

    def call
      note = Note.new(
        user: user,
        title: params[:title],
        content: params[:content]
      )

      if note.save
        @success = true
        @note = note
        self
      else
        add_error("Erro ao criar nota. Tente novamente.")
        self
      end
    end

    def note
      @note
    end

    private

    def note_params
      params.permit(:note).permit(:title, :content)
    end
  end
end