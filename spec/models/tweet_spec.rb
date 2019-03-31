require 'rails_helper'

RSpec.describe Tweet, type: :model do
	let(:tweet) { FactoryBot.create :tweet }
	
  describe "ActiveModel validations" do
  	it { expect(tweet).to validate_presence_of(:body) }
  	it { expect(tweet).to validate_length_of(:body) }
  end
  
  describe "ActiveRecord associations" do
  	it { expect(tweet).to belong_to(:user) }
  end
  
  describe "Public instance methods" do
  	context "#get_src_tweet" do
  		let(:tweet) { FactoryBot.create :tweet }
  		let(:retweet) { FactoryBot.create(:tweet, src_tweet: tweet) }
  		
  		it "should call the method" do
  			expect(retweet).to receive(:get_src_tweet)
  			retweet.get_src_tweet
  		end
  		
  		it "should return the src tweet" do
  			expect(retweet.get_src_tweet).to eq(tweet)
  		end
  		
  		it "should not have src tweet" do
  			expect(tweet.has_src_tweet?).to eq(false)
  		end
  	end
  end
  
end
