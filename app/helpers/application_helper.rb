module ApplicationHelper

  def section?(section)
    /^\/#{section}[\/.*]?/ =~ request.path
  end 

end
