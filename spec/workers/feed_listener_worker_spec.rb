require 'rails_helper'

RSpec.describe FeedListenerWorker, type: :worker do

  it 'starts connects to Twitter Streaming service' do
    expect(TwitterAPI)
      .to receive(:new)
    FeedListenerWorker.perform_async('1','2')
    # subject.perform(1, 'foo', 'bar')
  end

end
