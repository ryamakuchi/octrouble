require 'octrouble'
require 'thor'
require 'octokit'

module Octrouble
  class Cli < Thor
    desc 'issues REPO_URL', 'get Issues data from GitHub API'
    def issues(repo_url)
      puts "issues REPO_URL: #{repo_url}"
    end
  end
end
