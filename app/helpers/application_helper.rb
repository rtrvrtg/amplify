module ApplicationHelper
  def project_name; end

  def project_description; end

  def data_title_template; end

  def staging?
    Rails.env.staging?
  end

  def current_user_edits
    number = number_to_human(current_user.total_edits, format: "%n%u", units: { thousand: "K+" })
    content_tag :span, number, class: "select-active__admin-score"
  end

  def time_display(start_time)
    time = Time.at((start_time / 1000)).utc.strftime("%M:%S")
    time.to_s.slice!(0)
    time
  end

  def show_theme?
    @app_config.try(:show_theme?)
  end

  def show_institutions?
    @app_config.try(:show_institutions?)
  end

  def gtm_id
    ENV["GOOGLE_TAG_MANAGER_ID"] if ENV.key?("GOOGLE_TAG_MANAGER_ID")
  end

  # NOTE: format we need
  #       if the title is empty -> 'Amplify'
  #       if the title is not empty -> '<title> | Amplify'
  def page_title
    title = "Amplify"
    title.prepend("#{@page_title} | ") if @page_title
    title
  end

  # FIXME: this needs to be changed to the current time format
  def display_time(time)
    time_string = ""
    t = Time.at(time).utc
    h = t.hour
    m = t.min
    s = t.sec

    if h > 0 && m > 0
      time_string = "#{h}h #{m}m"
    elsif m > 0 && s > 0
      time_string = "#{m}m #{s}s"
    elsif s > 0
      time_string = "#{s}s"
    end
    time_string
  end

  def footer_link(link)
    return if link.title.blank? || link.url.blank?

    link_to link.title, link.url, target: :_blank
  end

  def conditional_separator(collection, index)
    return unless collection[index + 1] # in case it's the last element

    "/" if display_separator?(collection, index)
  end

  def display_separator?(collection, index)
    (presence_of(collection[index]) && future_element(collection, index + 1))
  end

  def presence_of(element)
    element&.title&.present? && element&.url&.present?
  end

  def future_element(collection, next_index)
    last_index = collection.size - 1

    (next_index..last_index).map do |i|
      presence_of(collection[i])
    end.any?
  end
end
