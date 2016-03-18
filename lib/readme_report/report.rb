# Do work
module ReadmeReport
  require 'awesome_bot'
  require 'colored'
  require 'github-readme'
  require 'readme-correct'

  LOGFILE = 'temp'

  class << self
    def correct(repo)
      name, temp = readme repo

      temp = check_correct temp, 'Xcode', ['XCode', 'xCode']
      temp = check_correct temp, 'CocoaPods', ['Cocoapods', 'Cocoa Pods', 'cocoa pods']
      temp = check_correct temp, 'pod install', ['pod update']

      puts "Checking links ..."
      log = AwesomeBot::Log.new(true)
      whitelisted = []
      r = AwesomeBot::check(temp, nil, false, log)

      issues_count = r.statuses_issues.count
      if issues_count==0
        puts 'No issues with links'.green
      else
        puts "Issues found: #{issues_count}".red
        r.statuses_issues.each_with_index do |s, i|
          url = s['url']
          status = s['status']
          print "#{i+1}. "
          if AwesomeBot.status_is_redirected? status
            redirect = s['headers']['location']
            puts "#{url} → #{redirect}"
            temp = temp.gsub url, redirect
          else
            if status != -1
              puts "#{s['status'].to_s.red} #{url}"
            else
              puts "#{url} #{s['error'].red}"
            end
          end
        end
      end

      # filename = LOGFILE
      # File.open(filename, 'w') { |f| f.write(temp) }
      # puts "Wrote updated content in #{filename}"
    end

    def check_correct(readme, correct, incorrect)
      is_incorrect = ReadmeCorrect::is_incorrect readme, incorrect

      print "Checking #{correct}: "
      puts is_incorrect ? 'Found issues'.red : 'No issues'.green

      is_incorrect ?
        ReadmeCorrect::corrected(readme, correct, incorrect) :
        readme
    end

    def readme(repo)
      r = GitHubReadme::get repo

      error = r['error']
      unless error.nil?
        puts "Error: no README for #{repo}".red
        exit
      end

      name = r['name']
      readme = r['readme']

      puts "README: #{name.white}"

      [name, readme]
    end
  end
end
