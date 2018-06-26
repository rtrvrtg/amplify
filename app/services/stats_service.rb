class StatsService
  attr_accessor :user

  def initialize(user)
    @user = user
  end

  def all_stats
    {
      transcript_edits: transcript_edits,
      user_registration_stats: user_registrations
    }
  end

  def transcript_edits
    {
      all: getStatsByDay.length,
      past_30_days: past_n_days(30).length,
      past_7_days: past_n_days(7).length,
      past_24_hours: past_n_days(1).length
    }
  end

  def user_registrations
    {
      all: user_get_stats_by_day.length,
      past_30_days: user_past_n_days(30).length,
      past_7_days: user_past_n_days(7).length,
      past_24_hours: user_past_n_days(1).length
    }
  end


  def past_n_days(days)
    getStatsByDay.where(created_at: days.days.ago..DateTime.now)
  end

  def user_past_n_days(days)
    user_get_stats_by_day.where(created_at: days.days.ago..DateTime.now)
  end


  private

  # original query
  def getStatsByDay
    TranscriptEdit.all
  end

  def user_get_stats_by_day
    User.all
  end
end
