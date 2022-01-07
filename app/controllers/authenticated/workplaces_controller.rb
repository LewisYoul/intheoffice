module Authenticated
  class WorkplacesController < AuthenticatedController
    def index
      @workplaces = current_account.workplaces.includes(:user_accounts)
    end

    #don't allow access unless admin
    def new
      @workplace = Workplace.new

      render 'new', formats: [:turbo_stream]
    end

    #don't allow access unless admin
    def create
      @workplace = current_account.workplaces.new(workplace_params)

      if @workplace.save
        @notification_heading = 'Workplace Created'
        @notification_description = 'You can now add members to this workplace'

        render :create
      else
        render turbo_stream: turbo_stream.replace(:workplace_form, partial: 'authenticated/workplaces/form')
      end
    end

    #don't allow access unless admin
    def edit
      @workplace = current_account.workplaces.find(params[:id])
      
      render 'edit', formats: [:turbo_stream]
    end
    
    #don't allow access unless admin
    def update
      @workplace = current_account.workplaces.find(params[:id])

      if @workplace.update(workplace_params)
        @notification_heading = 'Workplace Updated'
        @notification_description = 'You can now add members to this workplace'

        render :create
      else
        render turbo_stream: turbo_stream.replace(:workplace_form, partial: 'authenticated/workplaces/form')
      end
    end

    def destroy
      @workplace = current_account.workplaces.find(params[:id])

      if @workplace.destroy
        @notification_heading = 'Workplace Deleted'
        @notification_description = "You will no longer be able to assign members to this workplace"

        render :create
      else
        render turbo_stream: turbo_stream.replace(:workplace_form, partial: 'authenticated/workplaces/form')
      end
    end

    private

    def workplace_params
      params.require(:workplace).permit(:name)
    end
  end
end
