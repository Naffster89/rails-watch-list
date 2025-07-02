# Script to add more action movies to the Action Blockbusters list
require_relative 'config/environment'

# Get the Action Blockbusters list
action_list = List.find_by(name: "Action Blockbusters")

if action_list.nil?
  puts "Action Blockbusters list not found!"
  exit
end

puts "Found Action Blockbusters list (ID: #{action_list.id})"

# Find more action movies by specific titles
specific_action_movies = [
  "Die Hard",
  "Speed",
  "Mission: Impossible",
  "John Wick",
  "Mad Max: Fury Road",
  "The Dark Knight",
  "Inception",
  "Black Panther",
  "Wonder Woman",
  "Captain America: Civil War"
]

action_movies = []
specific_action_movies.each do |title|
  movies = Movie.where("LOWER(title) LIKE ?", "%#{title.downcase}%")
  action_movies.concat(movies)
end

# Also find some high-rated movies that might be action
high_rated_movies = Movie.where("rating >= 8.0").limit(10)

puts "Found #{action_movies.length} specific action movies and #{high_rated_movies.length} high-rated movies"

# Combine and remove duplicates
all_movies = (action_movies + high_rated_movies).uniq

# Add movies to the list
added_count = 0
all_movies.each do |movie|
  # Check if movie is already in the list
  existing_bookmark = Bookmark.find_by(list: action_list, movie: movie)
  
  if existing_bookmark.nil?
    # Create bookmark with a comment
    comment = "Added to Action Blockbusters - #{movie.title} (#{movie.rating}/10) - looks like an exciting movie!"
    bookmark = Bookmark.create!(
      list: action_list,
      movie: movie,
      comment: comment
    )
    puts "✓ Added: #{movie.title} (Rating: #{movie.rating})"
    added_count += 1
  else
    puts "  Already exists: #{movie.title}"
  end
end

puts "\nSuccessfully added #{added_count} more movies to Action Blockbusters list!"
puts "Total movies in Action Blockbusters: #{action_list.movies.count}" 