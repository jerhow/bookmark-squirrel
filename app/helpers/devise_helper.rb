module DeviseHelper
  def demo_field_helper(field)

    if field == :demo_email
      if !session[:demo_email].nil?
        return session[:demo_email]
      end
    end

    if field == :demo_pw
      if !session[:demo_pw].nil?
        return session[:demo_pw]
      end
    end

    ""

  end

  def demo_msg_helper
    if !session[:demo_email].nil? && !session[:demo_pw].nil?
      "NOTE: This is a temporary demo account. It will permanently expire in one hour."
    else
      ""
    end
  end
end
