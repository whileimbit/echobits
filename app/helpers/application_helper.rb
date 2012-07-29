module ApplicationHelper
	def format_text(text)
    sanitize markdown(text.to_s)
  end

  @@html_render  = Redcarpet::Render::HTML.new :hard_wrap => true, :no_styles => true
  @@markdown     = Redcarpet::Markdown.new @@html_render, :autolink => true, :no_intra_emphasis => true
  def markdown(text)
    @@markdown.render(text)
  end

  def format_time(time)
    timeago_tag time, :date_only => false, :limit => 1.hours.ago, :format => "%Y-%m-%d %H:%M"
  end
end
