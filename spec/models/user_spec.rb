require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { FactoryBot.build :user }
	let(:invalid_user) { FactoryBot.build :user, :invalid_user }
	
	describe "ActiveModel validations" do
		#Basic validations
		it { expect(user).to validate_presence_of(:username) }
		it { expect(user).to validate_presence_of(:email) }
		it { expect(user).to validate_presence_of(:name) }
		it { expect(user).to validate_length_of(:username) }
		it { expect(user).to validate_length_of(:name) }
		
		#Format validations
		it { expect(user).to allow_value("example@mail.com").for(:email) }
		it { expect(user).to_not allow_value("examplemail.com").for(:email) }
		it { expect(user).to_not allow_value("foo-bar").for(:username) }
		it "should not content special characters" do
			expect(invalid_user).to_not be_valid
		end
	end
	
	describe User do 
		it { should have_many(:tweets) }
	end
	
	describe "Public instance methods" do
		context "#retweet_it?" do

			let(:user) { FactoryBot.create(:user) }
			let(:tweet) { FactoryBot.create(:tweet) }
			let(:retweet) { FactoryBot.create(:tweet, user_id: user.id, src_tweet: tweet) }

			it "should call the method" do
				expect(user).to receive(:retweet_it?)
				user.retweet_it?(tweet)
			end
			it "should have retweet the tweet" do
				retweet.src_tweet = tweet
				expect(user.retweet_it?(tweet)).to eq(true)
			end
			it "should not have retweet the tweet" do
				expect(user.retweet_it?(tweet)).to eq(false)
			end
		end
	end
	
	
end
