class PagesController < ApplicationController
  def home
    @page_title = 'Home'
  end

  def our_school
    @page_title = 'Institution Chrétienne d'Haïti'
  end

  def fbla
    @page_title = "FBLA Haiti Chapter"
  end

  def about_us
    @page__title = "About Us"
  end

  def terms_of_service
    @page_title = "Terms of Service"
  end

  def privacy_policy
    @page_title = "Privacy Policy"
  end

end
