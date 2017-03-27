require 'spec_helper'
require 'json'
require 'pry'

describe PropublicaCongress::Member do

  let(:member) { PropublicaCongress::Member.new }

  it 'should exist' do
    expect(member).to be_kind_of(PropublicaCongress::Member)
  end

  context 'getting current House members' do
    subject { member.list('house') }

    it 'should return the 441 Members of the 115th U.S. House' do
      VCR.use_cassette('list_115_house') do
        body = JSON.parse(subject.body)
        results = body["results"][0]

        expect(body["status"]).to eq("OK")
        
        congress = results["congress"]
        expect(congress).to eq("115")
        
        chamber = results["chamber"]
        expect(chamber).to eq("House")

        num_results = results["num_results"]
        expect(num_results).to eq("441")
        
        members = results["members"]
        expect(members.count).to eq(441)
      end
    end
  end

  context 'getting current Senate members' do
    subject { member.list('senate') }

    it 'should return the 101 Members of the 115th U.S. Senate' do
      VCR.use_cassette('list_115_senate') do
        body = JSON.parse(subject.body)
        results = body["results"][0]

        expect(body["status"]).to eq("OK")
        
        congress = results["congress"]
        expect(congress).to eq("115")
        
        chamber = results["chamber"]
        expect(chamber).to eq("Senate")

        num_results = results["num_results"]
        expect(num_results).to eq("101")
        
        members = results["members"]
        expect(members.count).to eq(101)
      end
    end
  end

  context 'getting Senate members from 113' do
    subject { member.list('senate', 113) }

    it 'should return the 101 Members of the 115th U.S. Senate' do
      VCR.use_cassette('list_113_senate') do
        body = JSON.parse(subject.body)
        results = body["results"][0]

        expect(body["status"]).to eq("OK")
        
        congress = results["congress"]
        expect(congress).to eq("113")
        
        chamber = results["chamber"]
        expect(chamber).to eq("Senate")

        num_results = results["num_results"]
        expect(num_results).to eq("105")
        
        members = results["members"]
        expect(members.count).to eq(105)
      end
    end
  end

  context 'getting Member by ID' do
    subject { member.get('W000817') }

    it 'should return Elizabeth Warren' do
      VCR.use_cassette('member_W000817') do
        body = JSON.parse(subject.body)
        results = body["results"][0]

        expect(body["status"]).to eq("OK")
        
        expect(results["member_id"]).to eq("W000817")
        expect(results["first_name"]).to eq("Elizabeth")
      end
    end
  end

  context 'getting the most recent new members of the current Congress' do
    subject { member.get_new }

    it 'should return the 20 Members of the 115th Congress (House + Senate)' do
      VCR.use_cassette('list_new') do
        body = JSON.parse(subject.body)
        results = body["results"][0]

        expect(body["status"]).to eq("OK")
      
        num_results = results["num_results"]
        expect(num_results).to eq("20")
        
        members = results["members"]
        expect(members.count).to eq(20)
      end
    end
  end

end