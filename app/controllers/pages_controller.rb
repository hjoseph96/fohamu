class PagesController < ApplicationController
  def home
    @page_title = 'Home'
    @page_description = "Focus Haitian Music Inc. (FOHAMU) is a charitable,
    tax-exempt, 501(c)(3) organization dedicated to the growth and empowerment of
    Haitian youth and creating a brighter future for Haiti's tomorrow."
  end

  def our_school
    @page_title = "Institution Chrétienne d'Haïti"
    @page_description = "ICDH is a K12 school located in Carrefour, Haiti. Since
    2000, we've provided Haitian youth in an education far beyond the standards of
    the common Haitian educatino. At ICDH, we prepare our students to excel on an
    international scale."
  end

  def fbla
    @page_title = 'FBLA Haiti Chapter'
    @page_description = "FBLA Chapter Haiti has been the soel respresentative of
    Haiti within FBLA-PBL since 2011. Thorugh competing against international
    students, netowrking at the events, and experiencing international travel,
    our program prepares students for a collegiate education abroad. "
  end

  def about_us
    @page_title = 'About Us'
    @page_description = "Focus Haitian Music Inc. (FOHAMU) is a charitable,
    tax-exempt, 501(c)(3) organization. Since 1999, we have worked to give
    Haitian youth a stellar education and initiate them as well-informed,
    global citizens."
  end

  def terms_of_service
    @page_title = 'Terms of Service'
  end

  def privacy_policy
    @page_title = 'Privacy Policy'
  end

end
