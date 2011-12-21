module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Competely"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def menu_builder(tab, title)
  	if tab==title
  		"active"
  	else
  		"inactive"
  	end
  end
  
end