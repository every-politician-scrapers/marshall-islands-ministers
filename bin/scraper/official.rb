#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full:     entry.last,
        prefixes: %w[His Excellency President Honorable Honorbale]
      ).short
    end

    def position
      entry.first.sub(/^\d+\. /, '')
    end

    private

    def entry
      noko.css('.panel-heading').text.tidy.split(' - ', 2)
    end
  end

  class Members
    def member_container
      noko.css('.panel')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
