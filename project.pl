% Project 2 - Maze Solver
% Main predicate: find_exit/2
% First parameter: Maze (list of lists)
% Second parameter: Actions (list of directions)

% ==================== MAIN PREDICATE ====================

% find_exit/2 - Main predicate to solve the maze
% Succeeds if Actions lead from start to an exit
% Works with unbound Actions (generates solution)
find_exit(Maze, Actions) :-
    validate_maze(Maze),
    find_start(Maze, StartRow, StartCol),
    follow_path(Maze, StartRow, StartCol, Actions, FinalRow, FinalCol),
    get_cell(Maze, FinalRow, FinalCol, e).

% ==================== MAZE VALIDATION ====================

% validate_maze/1 - Ensures maze is valid
% Checks: not empty, rectangular, exactly 1 start, at least 1 exit
validate_maze(Maze) :-
    Maze \= [],
    all_same_length(Maze),
    count_cells(Maze, s, 1),
    count_cells(Maze, e, Count),
    Count >= 1.

% all_same_length/1 - Checks all rows have same length
all_same_length([]).
all_same_length([_]).
all_same_length([Row1, Row2 | Rest]) :-
    length(Row1, Len),
    length(Row2, Len),
    all_same_length([Row2 | Rest]).

% count_cells/3 - Counts occurrences of a cell type in maze
count_cells(Maze, CellType, Count) :-
    flatten(Maze, FlatMaze),
    findall(CellType, member(CellType, FlatMaze), Cells),
    length(Cells, Count).

% ==================== POSITION FINDING ====================

% find_start/3 - Finds the starting position (s) in the maze
% Returns Row and Col indices (0-based)
find_start(Maze, Row, Col) :-
    find_cell_position(Maze, s, 0, Row, Col).

% find_cell_position/5 - Helper to find any cell type
find_cell_position([CurrentRow | _], CellType, RowIndex, RowIndex, ColIndex) :-
    find_in_row(CurrentRow, CellType, 0, ColIndex).
find_cell_position([_ | RestRows], CellType, CurrentIndex, Row, Col) :-
    NextIndex is CurrentIndex + 1,
    find_cell_position(RestRows, CellType, NextIndex, Row, Col).

% find_in_row/4 - Finds cell in a specific row
find_in_row([CellType | _], CellType, ColIndex, ColIndex).
find_in_row([_ | RestCols], CellType, CurrentIndex, ColIndex) :-
    NextIndex is CurrentIndex + 1,
    find_in_row(RestCols, CellType, NextIndex, ColIndex).

% ==================== PATH FOLLOWING ====================

% follow_path/6 - Follows a list of actions from a starting position
% Base case: no more actions, return current position
follow_path(_, Row, Col, [], Row, Col).

% Recursive case: process one action and continue
follow_path(Maze, Row, Col, [Action | RestActions], FinalRow, FinalCol) :-
    move(Action, Row, Col, NewRow, NewCol),
    is_valid_move(Maze, NewRow, NewCol),
    follow_path(Maze, NewRow, NewCol, RestActions, FinalRow, FinalCol).

% ==================== MOVEMENT ====================

% move/5 - Calculates new position based on action
% left: decrease column
move(left, Row, Col, Row, NewCol) :-
    NewCol is Col - 1.

% right: increase column
move(right, Row, Col, Row, NewCol) :-
    NewCol is Col + 1.

% up: decrease row
move(up, Row, Col, NewRow, Col) :-
    NewRow is Row - 1.

% down: increase row
move(down, Row, Col, NewRow, Col) :-
    NewRow is Row + 1.

% ==================== VALIDATION HELPERS ====================

% is_valid_move/3 - Checks if a move is legal
% Must be within bounds and not a wall
is_valid_move(Maze, Row, Col) :-
    Row >= 0,
    Col >= 0,
    length(Maze, NumRows),
    Row < NumRows,
    nth0(Row, Maze, CurrentRow),
    length(CurrentRow, NumCols),
    Col < NumCols,
    get_cell(Maze, Row, Col, Cell),
    Cell \= w.

% get_cell/4 - Gets the cell at a specific position
get_cell(Maze, Row, Col, Cell) :-
    nth0(Row, Maze, CurrentRow),
    nth0(Col, CurrentRow, Cell).

% ==================== UTILITY PREDICATES ====================

% maze_dimensions/3 - Gets the dimensions of the maze
maze_dimensions(Maze, Rows, Cols) :-
    length(Maze, Rows),
    Maze = [FirstRow | _],
    length(FirstRow, Cols).

% flatten/2 - Flattens a list of lists into a single list
flatten([], []).
flatten([[] | Rest], Flat) :-
    flatten(Rest, Flat).
flatten([[Head | Tail] | Rest], [Head | Flat]) :-
    flatten([Tail | Rest], Flat).
flatten([Atom | Rest], [Atom | Flat]) :-
    \+ is_list(Atom),
    flatten(Rest, Flat).
