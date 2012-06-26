# so that we can use Time.parse()
require 'time'
module Todo
  class Task
    def initialize(title, created_at=Time.now, completed_at=nil)
      @title = title
      @created_at = created_at
      @completed_at = completed_at
    end

    # a factory method on Task to parse a string and return a new task
    def self.from_string(string)
      # we expect a string in a format like this:
      # "eat food ; 2012-06-25 23:18:31 -0700 ; 2012-06-25 23:18:31 -0700"
      # so we split it on ';' and strip out any extra spaces on the ends
      array = string.split(';').collect(&:strip)

      title = array[0]

      # if created_at is blank then we want to set it to now
      created_at = array[1].nil? ? Time.now : Time.parse(array[1])

      # let completed_at be nil if it's blank
      completed_at = Time.parse(array[2]) unless array[2].nil?

      # this initializes and returns a new instance of Task
      self.new(title, created_at, completed_at)
    end

    def to_s
      # you don't need to use {} when you're interpolating instance variables
      "#@title ; #@created_at ; #@completed_at"
    end

    def complete!
      @completed_at = Time.now
    end

    def complete?
      !incomplete?
    end

    def incomplete?
      @completed_at.nil?
    end
  end
end
