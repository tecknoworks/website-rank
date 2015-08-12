class Website < ActiveRecord::Base
  validates :url, url: true

  after_commit :queue_up, on: :create

  def queue_up
    RankWorker.perform_in(1.seconds, id)
  end

  def results
    if score?
      " - #{score}"
    else
      begin
        payload["textStatus"]
      rescue
        'processing'
      end
    end
  end

  def to_s
    "#{id} #{url} #{score}"
  end
end
