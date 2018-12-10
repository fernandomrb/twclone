require 'rails_helper'

RSpec.describe Tweet, type: :model do
	let(:tweet) { FactoryGirl.build :tweet }
	
  describe "ActiveModel validations" do
  	it { expect(tweet).to validate_presence_of(:body) }
  	it { expect(tweet).to validate_length_of(:body) }
  end
  
  describe "ActiveRecord associations" do
  	it { expect(tweet).to belong_to(:user) }
  end
  
  describe "Public instance methods" do
  	context "#get_src_tweet" do
  		let(:tweet) { FactoryGirl.create :tweet }
  		let(:retweet) { FactoryGirl.create(:tweet, src_tweet: tweet) }
  		
  		it "should call the method" do
  			expect(retweet).to receive(:get_src_tweet)
  			retweet.get_src_tweet
  		end
  		
  		it "should return the src tweet" do
  			expect(retweet.get_src_tweet).to eq(tweet)
  		end
  		
  		it "should not have src tweet" do
  			expect(tweet.get_src_tweet).to eq(nil)
  		end
  	end
  end
  
end
