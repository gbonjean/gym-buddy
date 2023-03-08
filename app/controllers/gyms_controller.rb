class GymsController < ApplicationController

  def index
    @gyms = Gym.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @gyms.geocoded.map do |gym|
      {
        lat: gym.latitude,
        lng: gym.longitude,

        info_window_html: render_to_string(partial: "info_window", locals: {gym: gym}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @gym = Gym.find(params[:id])
    @events = @gym.events
  end
end
