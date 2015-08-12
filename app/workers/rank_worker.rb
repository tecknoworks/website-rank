require 'json'

class RankWorker
  include Sidekiq::Worker

  def perform(id)
    website = Website.find(id)
    ranker = Ranker.new(website.url)
    website.update(score: ranker.json["overallResultScore"], json: ranker.json, sid: ranker.sid)
  end
end
