#2025-12-10 09:12
##Thoughts so far
-Just opened up Project 2 (Prolog maze thing). Haven’t touched Prolog in a minute so I’m kinda nervous again. Need to re-remember how predicates/backtracking/unification all feel in my hands instead of just in theory. Conceptually it doesn’t look too crazy, but Prolog always has that “one small logic mistake = nothing works” energy.

##Plan for this session
skim the writeup slowly and actually absorb it
rough out the flow in the README with some quick pseudocode
pull up a couple Prolog refresher videos in the background
peek at example.pl + test.pl to see how they expect mazes/actions to look

#2025-12-10 10:30
##Thoughts so far
-Read through the spec and tossed some pseudocode into the README. Validation looks like the part that can get annoying: exactly one start, at least one exit, rows same length, etc. Also need to keep track of coordinates cleanly so I don’t confuse myself later.

##Plan for now
set up the basic skeleton for the project file
start with small helpers first (get_cell, maze_dimensions)
test each helper as I go so I don’t debug everything at the end

#2025-12-10 11:46
##Thoughts so far
-Got the first layer of structure in. Wrote get_cell and maze_dimensions. List indexing in Prolog is a little annoying coming from other languages—ended up committing to 0-indexed with nth0 so I don’t mix nth0/nth1 by accident.

##Plan for now
write validate_maze
add a count_cells helper
throw a couple tiny mazes at it to see if validation behaves

#2025-12-10 13:25
##Thoughts so far
-Took a break and ate leftover pizza. Validation is working now, which is nice. count_cells was a bit annoying because I had to remember how to flatten and filter in Prolog. Ended up using findall after googling the syntax again.

##Plan for now
implement find_start
test it on a few different maze shapes
start mentally sketching how the path-following recursion should look

#2025-12-10 14:56
##Thoughts so far
-find_start works. Did the usual nested “loop” with helpers to walk rows/cols. Now I’m at the actual hard-ish part: following the path. Need to be careful with the recursion + base case and make sure the position gets updated correctly each step.

##Plan for now
write move/4 (action + current pos → new pos)
write is_valid_move/3 to gate out walls / out-of-bounds
then start wiring up follow_path

#2025-12-10 16:11
##Thoughts so far
-Path following kinda works, but the base case logic feels off. Not fully sure when I should be checking for the exit. Pretty sure it should be after I finish all the actions, not in the middle. Also realized I wasn’t consistently threading the current position through the recursion, which explains some of the weirdness.

##Plan for now
fix follow_path so the base case makes sense
add a clean exit check at the end of the action list
test on a super small maze with a known solution

#2025-12-10 17:42
##Thoughts so far
-Think I figured it out. The bug was exactly what I suspected: I wasn’t passing the updated position through the recursive calls properly. Patched that and now it works on a tiny 3x3 maze. Still need to hit more edge cases but the core idea feels solid.

##Plan for now
throw invalid mazes at it (no start, multiple starts, etc.)
test mazes with no solution
try mazes with multiple exits
make sure it actually fails when it’s supposed to

#2025-12-10 19:51
##Thoughts so far
-Edge cases look good. Validation catches bad mazes, and the path logic correctly fails when there’s no way out. Also confirmed that leaving the second arg unbound works—Prolog just backtracks and coughs up a valid action list, which is kinda fun to watch.

##Plan for now
clean up the predicate names / structure a bit
add short comments so future-me knows what each thing does
test with gen_map/4 on some bigger random mazes
re-skim the spec to make sure I didn’t miss anything

#2025-12-10 20:24
##Thoughts so far
-Ran gen_map/4 with a 5x5 maze (complexity 4) and the solver actually finds a path, so that’s a good sign. Did a quick pass to clean the code and add comments. Tossed in a couple extra helper predicates just to make things easier to read.

##Plan for now
do one more requirements pass
check that my git commits look sane (not just one giant dump)
test a few more random mazes
get ready for submission

#2025-12-10 21:41
##Thoughts so far
-Did a final round of testing:
-small mazes (2x2, 3x3)
-bigger generated ones (5x5, 10x10)
-invalid mazes to make sure they fail
-mazes with multiple exits
Everything passes. Code is clean enough and commented. Git history shows a reasonable progression instead of chaos.

##Plan for now
write any last comments I want to leave for future-me
make sure this devlog is filled out properly
zip everything and submit

#2025-12-10 21:50
##Thoughts so far
-Project’s done. Honestly feel pretty good about this one. Prolog is still a bit cursed, but once the backtracking model clicked again it felt manageable. Breaking everything into tiny predicates and testing as I went was definitely the move. Way more comfortable with Prolog now than I was this morning.

##Plan for now
actually submit it
crash soon since I got work in the morning
if I somehow have energy, maybe glance at finals stuff before bed