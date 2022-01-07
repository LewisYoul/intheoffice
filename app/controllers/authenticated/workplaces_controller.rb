module Authenticated
  class WorkplacesController < AuthenticatedController
    def index
      @workplaces = current_account.workplaces.includes(:user_accounts)
    end

    def new
      @workplace = Workplace.new

      render 'new', formats: [:turbo_stream]
    end

    def create
      @workplace = current_account.workplaces.new(workplace_params)

      if !@workplace.save
        render turbo_stream: turbo_stream.replace(:new_workplace_form, partial: 'authenticated/workplaces/form')
      end
    end

    private

    def workplace_params
      params.require(:workplace).permit(:name)
    end
  end
end
