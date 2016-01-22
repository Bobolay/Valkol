class PagesController < ApplicationController
	def index
		@certificates = [{img: '/assets/img.jpg'}]
	end
end