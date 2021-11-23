module Authenticated
  class EventsController < AuthenticatedController
    def index
      @events = Event.includes(:participants).order(event_date: :desc)
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)

      if @event.save
        redirect_to events_path # update to show
      else
        render :new
      end
    end

    private

    def event_params
      params.require(:event).permit(
        :title,
        :content,
        :event_date,
        :user_id,
        :account_id,
        participant_ids: [],
      )
    end
  end
end