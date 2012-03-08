require 'thor'
require 'gitscrub'
module Gitscrub
  class CLI < Thor


    default_task :setup

    desc :setup, "Initialize the game"

    def setup
      UI.word_box("Gitscrub")
      make_directory
      game = Game.new
      game.play_level
    end

    desc :check, "check your current solution"

    def check
      true
    end

    desc :reset, "reset the current level"

    def reset
      profile = Profile.load
      level = Level.load(profile.level)
      if level
        UI.word_box("Gitscrub")
        UI.puts("resetting level")
        level.setup_level
        level.full_description
      end
    end

    no_tasks do

      def make_directory
        if File.exists?("./git_scrub") 
          UI.puts "Please change into the git_scrub directory"
          exit
        end

        unless File.basename(Dir.pwd) == "git_scrub"
          if UI.ask("No gitscrub directory found, do you wish to create one?")
            Dir.mkdir("./git_scrub")
            Dir.chdir("git_scrub")
            File.open(".gitignore", "w") do |file|
              file.write(".profile.yml")
            end
          else
            UI.puts("Exiting")
            exit
          end
        end
      end

    end

  end
end