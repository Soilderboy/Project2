#2025-12-10 09:00
##Thoughts so far
Starting project 2, it's a prolog maze solver. Honestly haven't touched prolog in forever so I'm kinda nervous. Need to look up how backtracking works again and refresh on predicates
##Plan for this session
Read the pdf and figure out what I need to do
Map it out in the README
Maybe watch a video or two on prolog basics

#2025-12-10 10:15
##Thoughts so far
Ok so I need to make find_exit/2 that takes a maze and returns a list of actions. The maze is just nested lists with s (start), e (exit), f (floor), w (wall). Actions are left/right/up/down. Need to validate the maze too - exactly 1 start, at least 1 exit, all rows same length
##Plan for now
Write pseudocode in README
Start implementing helper predicates
Get the basic structure down

#2025-12-10 11:30
##Thoughts so far
Got get_cell and some basic helpers working. Prolog's list indexing is kinda annoying but whatever, using nth0 everywhere. The maze validation logic is next
##Plan for now
Implement validate_maze
Count cells to check for start/exit
Test with simple mazes

#2025-12-10 13:00
##Thoughts so far
Grabbed some food. Validation is done - used findall to count cells which I had to look up. It's working though
##Plan for now
Implement find_start to locate the starting position
Start thinking about how to follow the path

#2025-12-10 14:45
##Thoughts so far
find_start is working, just loops through rows and columns until it finds 's'. Now I need to do the actual pathfinding which is gonna be the hard part
##Plan for now
Make a move predicate that calculates new positions
Check if moves are valid (not wall, not off maze)
Recursive follow_path predicate

#2025-12-10 16:00
##Thoughts so far
Path following is kinda working but the base case is confusing me. Do I check for exit during or after? I think after all actions are done
##Plan for now
Fix the recursion
Make sure position gets updated correctly
Test with a simple maze

#2025-12-10 17:30
##Thoughts so far
Finally got it! The trick was threading the position through the recursion properly. Tested with a 3x3 maze and it works
##Plan for now
Test edge cases - no start, multiple starts, walls, going off the map
Make sure it fails when it should

#2025-12-10 18:45
##Thoughts so far
All the edge cases work. It correctly rejects invalid mazes and finds paths when they exist. Also works with unbound second parameter which is cool - prolog just generates solutions
##Plan for now
Clean up the code
Add comments
Test with example.pl and test.pl files

#2025-12-10 20:00
##Thoughts so far
Tested with the provided files and everything passes. Used gen_map to make a random 5x5 maze and it solved it. Code is cleaned up with comments
##Plan for now
Final check of requirements
Make sure git is good
Test one more time

#2025-12-10 21:30
##Thoughts so far
Did final testing - simple mazes, complex mazes, invalid ones, everything works. Code looks good and is well commented. Git commits are all there
##Plan for now
Make sure devlog is done
Submit
Get some sleep cuz I got work tmr morning
