difficulty 1
description "Among the files in this repository, which of them is untracked?"

setup do
  repo.init
  %w{config.rb README setup.rb deploy.rb Guardfile}.each do |file|
    FileUtils.touch(file)
    system "git branch -m master"
    repo.add(file)
  end
  FileUtils.touch("database.yml")
end

solution do

  name = request("What is the full file name of the untracked file?")

  if name != "database.yml"
    return false
  end

  true
end

hint do
  puts "You are looking for a command to identify the status of the repository."
end
