class PagesController < ApplicationController
  require 'net/http' 

  def search
    if params[:search]
      Repository.reindex
      @repos = Repository.search(params[:search])
    end
  end

  def search_github
    uri = URI("https://api.github.com/search/repositories?q=#{params[:search]}+language:#{params[:language]}&sort=stars&order=desc")
    res = Net::HTTP.get_response(uri)
    data = JSON.parse(res.body)
    data["items"].each do |repo|
      record = Repository.find_by_repo_id(repo["id"])
      unless record.present?
        record = Repository.new(repo_id: repo["id"])
      end
      record.name = repo["name"]
      record.owner = repo["owner"]["login"]
      record.owner_url = repo["owner"]["html_url"]
      record.html_url = repo["html_url"]
      record.description = repo["description"]
      record.stargazers_count = repo["stargazers_count"]
      record.watcher_count = repo["watcher_count"]
      record.save
    end
  end
end
