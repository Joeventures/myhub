require "sinatra/base"
require "httparty"
require "pry"

require "myhub/version"
require "myhub/github"

module Myhub
  class App < Sinatra::Base
    set :logging, true

    # Your code here ...
    get "/" do
      api = Github.new
      # get stuff from github
      repo_issues = api.list_repo_issues("TIY-ATL-ROR-2015-Sep", "assignments")
      stuff = repo_issues.map { |i| {id: i['number'], state: i['state']} }
      erb :index, locals: { issues: stuff }
    end

    post "/issue/reopen/:id" do
      binding.pry
      api = Github.new
      #api.reopen_issue(params["id"].to_i)
      api.edit_issue_state("TIY-ATL-ROR-2015-Sep", "assignments", @params['id'].to_i,"open")
      redirect to('/')
    end

    post "/issue/close/:id" do
      api = Github.new
      #api.close_issue(params["id"].to_i)
      api.edit_issue_state("TIY-ATL-ROR-2015-Sep", "assignments", @params['id'].to_i, "closed")
      redirect to('/')
    end

    run! if app_file == $0

  end
end