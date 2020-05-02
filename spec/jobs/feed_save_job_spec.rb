require 'rails_helper'

RSpec.describe FeedSaveJob, type: :job do
  include ActiveJob::TestHelper

  describe "Perform Job" do
    context "#perform later" do
      before(:each) do
        ActiveJob::Base.queue_adapter = :test
        @feed = build(:feed, user: create(:confirmed_user))
        @feed.content = Encryption.encrypt_data(@feed.content)
      end

      it 'queues the job' do
        expect { FeedSaveJob.set(wait: 10.minutes).perform_later(@feed.user.id, @feed.content) }
          .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
      end

      it 'is in default queue' do
        expect(FeedSaveJob.new.queue_name).to eq('default')
      end

      it "reponds to #perform" do
        expect(FeedSaveJob.new).to respond_to(:perform)
      end

      it "have_been_enqueued" do
        FeedSaveJob.set(wait: 10.minutes).perform_later(@feed.user.id, @feed.content)
        expect(FeedSaveJob).to have_been_enqueued.with(@feed.user.id, @feed.content)
      end

      it "saves the feed to the DB" do
        expect { FeedSaveJob.perform_now(@feed.user.id, @feed.content) }.to change(Feed, :count).by(1)
      end
    end
  end
end
