class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details" })
  end

  def create
    venue = Venue.new

    venue.address = params.fetch("query_address")
    venue.name = params.fetch("name")
    venue.neighborhood = params.fetch("neighborhood")

    venue.save

    redirect_to("/venues/#{venue.name}")
  end
  
  def update
    v_id = params.fetch("the_id")
    matching_venues = Venue.where({ :id => v_id })
    the_venue = matching_venues.at(0)
    
    input_address = params.fetch("query_address")
    input_name = params.fetch("query_name")
    input_neighborhood = params.fetch("query_neighborhood")

    the_venue.address = input_address
    the_venue.name = input_name
    the_venue.neighborhood = input_neighborhood

    the_venue.save
    
    next_url = "/venues/" + the_venue.id.to_s
    redirect_to(next_url)
  end

  def destroy
    the_id = params.fetch("venue_id")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues

    venue.destroy

    redirect_to("/venues")
  end
end
