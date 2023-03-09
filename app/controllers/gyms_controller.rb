class GymsController < ApplicationController

  def index
    @gyms = Gym.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @gyms.geocoded.map do |gym|
      {
        lat: gym.latitude,
        lng: gym.longitude,

        info_window: render_to_string(partial: "info_window", locals: {gym: gym}),
        image_url: helpers.asset_url("marker-orange.png")

      }
    end
  end

  def show
    @gym = Gym.find(params[:id])
    @events = @gym.events
  end
end
