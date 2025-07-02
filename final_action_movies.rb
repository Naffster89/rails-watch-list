# Final script to add authentic action movies
require_relative 'config/environment'

action_list = List.find_by(name: "Action Blockbusters")
puts "Adding final action movies to: #{action_list.name}"

# Classic action movies that should definitely be in the list
classic_action_titles = [
  "Die Hard",
  "Speed", 
  "Mission: Impossible",
  "John Wick",
  "Mad Max: Fury Road",
  "The Dark Knight",
  "Inception",
  "Black Panther",
  "Wonder Woman",
  "Captain America: Civil War",
  "Iron Man",
  "Thor: Ragnarok",
  "Guardians of the Galaxy",
  "Spider-Man: Homecoming",
  "Deadpool",
  "Logan",
  "X-Men: Days of Future Past",
  "Kingsman: The Secret Service",
  "Edge of Tomorrow",
  "Pacific Rim"
]

added_count = 0
classic_action_titles.each do |title|
  movies = Movie.where("LOWER(title) LIKE ?", "%#{title.downcase}%")
  
  movies.each do |movie|
    existing_bookmark = Bookmark.find_by(list: action_list, movie: movie)
    
    if existing_bookmark.nil?
      comment = "Classic action movie! #{movie.title} (#{movie.rating}/10) - A must-watch for action fans!"
      Bookmark.create!(
        list: action_list,
        movie: movie,
        comment: comment
      )
      puts "✓ Added: #{movie.title}"
      added_count += 1
    end
  end
end

puts "\n🎬 Added #{added_count} more authentic action movies!"
puts "🎯 Total movies in Action Blockbusters: #{action_list.movies.count}"
puts "🔥 Your Action Blockbusters list is now complete!" 