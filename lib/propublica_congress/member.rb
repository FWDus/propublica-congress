require 'httparty'
require 'json'

module PropublicaCongress

  # Represents a member object returned by the ProPublica Congerss API.
  # A member is a person who holds office in either the U.S. House of 
  # Representatives or the U.S. Senate.
  class Member

    API_URI = 'https://api.propublica.org'
    API_VERSION = 'v1'
    CURRENT_CONGRESS = 115
    API_URL = "#{API_URI}/congress/#{API_VERSION}"
    
    attr_reader :id, :api_uri, :first_name, :middle_name, :last_name, :party,
    :leadership_role, :twitter_account, :facebook_account, :twitter_account,
    :govtrack_id, :cspan_id, :votesmart_id, :icpsr_id, :crp_id, :google_entity_id,
    :url, :rss_url, :domain, :dw_nominate, :ideal_point, :seniority, :next_election,
    :total_votes, :missed_votes, :total_present, :ocd_id, :office, :phone, :state, 
    :senate_classs, :state_rank, :lis_id, :missed_votes_pct, :votes_with_party_pct

    def initialize
      api_key = ENV['PROPUBLICA_API_KEY']
      raise "You must initialize the API key before you run any API queries" if api_key.nil?
      @api_key = api_key
    end

    def headers
      {"X-API-Key" => @api_key}
    end

    # Retrieve a list of members of congress by chamber.
    # Defaults to the current cycle.
    def list(chamber, congress=CURRENT_CONGRESS)
      HTTParty.get("#{API_URL}/#{congress}/#{chamber}/members.json", headers: headers)
    end

    def get(member_id)
      HTTParty.get("#{API_URL}/members/#{member_id}.json", headers: headers)
    end

    def get_new
      HTTParty.get("#{API_URL}/members/new.json", headers: headers)
    end

  end
end