class PagesController < ApplicationController
	before_action :set_page_instance, except: [:index]
	before_action :add_home_breadcrumb, except: [:index]
	before_action except: [:under_construction, :index, :process_page, :career] do
		add_breadcrumb(action_name)
	end

	caches_page :index, :about_us, :contacts, :process_page, :sitemap

	def index
		set_page_metadata(:home)
		@home_page_info = HomePageInfo.first_or_initialize
		@certificates = Certificate.published.sort_by_sorting_position
		@publications = Publication.published.featured
		@interesting_articles = InterestingArticle.published.featured
		@home_banners = HomeBanner.published.sort_by_sorting_position
	end

	def about_us
		@members = Member.all
		@certificates = Certificate.published.sort_by_sorting_position
		@about_us_page_info = AboutUsPageInfo.first_or_initialize



	end
	def contacts
		@google_map = true
	end

  def pricing
		@pricing_page_info = PricingPageInfo.first_or_initialize
		@application_forms = ApplicationForm.published.sort_by_sorting_position
	end

	def set_page_instance
		set_page_metadata(action_name)
		set_page_banner_image(@page_instance.try(:page_banner))
	end
end