require 'octrouble'
require 'thor'
require 'octokit'

module Octrouble
  class Cli < Thor
    desc 'issues', 'get Issues data from GitHub API'
    option :page
    def issues(repo='rails/rails')
      page = options[:page] ? options[:page] : 1
      issues = Octokit.list_issues(repo, page: page)
      issues.each do | issue |
        puts "\"#{issue.title[0, 30]}\"," \
          "\"#{issue.body[0, 50]}\"," \
          "\"#{issue.html_url}\"\n"
      end
    end
  end
end
