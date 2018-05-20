class SearchController < ApplicationController
  before_action :set_search_params

  def show
    @search_results =
      @search.blank? ? [] : ThinkingSphinx.search(@search)
    respond_with(@search_results)
  end

  private

  def set_search_params
    @search = params[:search]
    @search.gsub!('@', '\\@') if @search.include?('@')
  end
end
