class PagesController < ApplicationController
	before_action :set_page_instance, except: [:index]
	before_action :add_home_breadcrumb, except: [:under_construction, :index, :career]
	before_action except: [:under_construction, :index, :process_page, :career] do
		add_breadcrumb(action_name)
	end

	caches_page :index, :about_us, :contacts, :process_page, :sitemap

	def index
		set_page_metadata("home")
		@certificates = [{img: '/assets/img.jpg'}]
		@publications = Publication.published
		@interesting_articles = InterestingArticle.published
	end

	def about_us
		@members = Member.all
		@certificates = Certificate.published.sort_by_sorting_position
	end
	def contacts

	end

	def set_page_instance
		set_page_metadata(action_name)
	end
end