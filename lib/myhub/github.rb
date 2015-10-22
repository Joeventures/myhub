module Myhub
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    # Your code here too!
    def initialize
      @headers = {
        "Authorization"  => "token #{ENV["AUTH_TOKEN"]}",
        "User-Agent"     => "HTTParty"
      }
    end

    def list_repo_issues(owner, repo)
      Github.get(
          "/repos/#{owner}/#{repo}/issues",
          :headers => @headers,
          :query    => { state: "all", filter: "assigned", assignee: "Joeventures" }
      )
    end

    def edit_issue_state(owner, repo, number, new_state)
      Github.patch(
          "/repos/#{owner}/#{repo}/issues/#{number}",
          :headers => @headers,
          :body    => { state: new_state }.to_json
      )
    end
  end
end
