class PagesController < ApplicationController
	def index
		@certificates = [{img: '/assets/img.jpg'}]
		render template: "pages/index", layout:  "application"
	end

	def about_us
	end
	def contacts
	end
end