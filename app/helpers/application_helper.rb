module ApplicationHelper
	# set title for each page
	def full_title(page_title = '')
    base_title = "Demo Ruby On Rails Framgia"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
