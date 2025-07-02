# Script to add action movies to the Action Blockbusters list
require_relative 'config/environment'

# Get the Action Blockbusters list
action_list = List.find_by(name: "Action Blockbusters")

if action_list.nil?
  puts "Action Blockbusters list not found!"
  exit
end

puts "Found Action Blockbusters list (ID: #{action_list.id})"

# Find some action movies by title keywords
action_keywords = ['action', 'adventure', 'thriller', 'war', 'fight', 'battle', 'mission', 'force', 'guardian', 'avenger', 'terminator', 'die hard', 'speed', 'matrix', 'gladiator', 'troy', '300', 'mad max', 'john wick', 'mission impossible']

action_movies = []
action_keywords.each do |keyword|
  movies = Movie.where("LOWER(title) LIKE ?", "%#{keyword}%").limit(5)
  action_movies.concat(movies)
end

# Remove duplicates and limit to 10 movies
action_movies = action_movies.uniq.first(10)

puts "Found #{action_movies.length} potential action movies:"
action_movies.each do |movie|
  puts "  #{movie.id}: #{movie.title}"
end

# Add movies to the list
added_count = 0
action_movies.each do |movie|
  # Check if movie is already in the list
  existing_bookmark = Bookmark.find_by(list: action_list, movie: movie)
  
  if existing_bookmark.nil?
    # Create bookmark with a comment
    comment = "Added to Action Blockbusters - #{movie.title} looks like an exciting action movie!"
    bookmark = Bookmark.create!(
      list: action_list,
      movie: movie,
      comment: comment
    )
    puts "✓ Added: #{movie.title}"
    added_count += 1
  else
    puts "  Already exists: #{movie.title}"
  end
end

puts "\nSuccessfully added #{added_count} movies to Action Blockbusters list!"
puts "Total movies in Action Blockbusters: #{action_list.movies.count}" 