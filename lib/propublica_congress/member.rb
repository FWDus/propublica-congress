module PropublicaCongress
  class Member < Base

    # Represents a member object returned by the ProPublica Congerss API.
    # A member is a person who holds office in either the U.S. House of 
    # Representatives or the U.S. Senate.
    attr_reader :id, :api_uri, :first_name, :middle_name, :last_name, :party,
    :leadership_role, :twitter_account, :facebook_account, :twitter_account,
    :govtrack_id, :cspan_id, :votesmart_id, :icpsr_id, :crp_id, :google_entity_id,
    :url, :rss_url, :domain, :dw_nominate, :ideal_point, :seniority, :next_election,
    :total_votes, :missed_votes, :total_present, :ocd_id, :office, :phone, :state, 
    :senate_classs, :state_rank, :lis_id, :missed_votes_pct, :votes_with_party_pct

    def initialize(params={})
      params.each_pair do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end

    # Retrieve a list of members of congress by chamber.
    # Defaults to the current cycle.
    def self.list(chamber, congress=CURRENT_CONGRESS)
      print chamber
      
    end
  end
end