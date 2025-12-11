% project 2 - maze solver
% find_exit/2 takes maze and returns list of actions

% main predicate
find_exit(Maze, Actions) :-
    validate_maze(Maze),
    find_start(Maze, StartRow, StartCol),
    follow_path(Maze, StartRow, StartCol, Actions, FinalRow, FinalCol),
    get_cell(Maze, FinalRow, FinalCol, e).

% validate maze - check not empty, rectangular, exactly 1 start, at least 1 exit
validate_maze(Maze) :-
    Maze \= [],
    all_same_length(Maze),
    count_cells(Maze, s, 1),
    count_cells(Maze, e, Count),
    Count >= 1.

% check all rows have same length
all_same_length([]).
all_same_length([_]).
all_same_length([Row1, Row2 | Rest]) :-
    length(Row1, Len),
    length(Row2, Len),
    all_same_length([Row2 | Rest]).

% count how many of a cell type appear in maze
count_cells(Maze, CellType, Count) :-
    flatten(Maze, FlatMaze),
    findall(CellType, member(CellType, FlatMaze), Cells),
    length(Cells, Count).

% find starting position
find_start(Maze, Row, Col) :-
    find_cell_position(Maze, s, 0, Row, Col).

% helper to find cell position
find_cell_position([CurrentRow | _], CellType, RowIndex, RowIndex, ColIndex) :-
    find_in_row(CurrentRow, CellType, 0, ColIndex).
find_cell_position([_ | RestRows], CellType, CurrentIndex, Row, Col) :-
    NextIndex is CurrentIndex + 1,
    find_cell_position(RestRows, CellType, NextIndex, Row, Col).

% find cell in a row
find_in_row([CellType | _], CellType, ColIndex, ColIndex).
find_in_row([_ | RestCols], CellType, CurrentIndex, ColIndex) :-
    NextIndex is CurrentIndex + 1,
    find_in_row(RestCols, CellType, NextIndex, ColIndex).

% follow path - base case when no more actions
follow_path(_, Row, Col, [], Row, Col).

% follow path - recursive case
follow_path(Maze, Row, Col, [Action | RestActions], FinalRow, FinalCol) :-
    move(Action, Row, Col, NewRow, NewCol),
    is_valid_move(Maze, NewRow, NewCol),
    follow_path(Maze, NewRow, NewCol, RestActions, FinalRow, FinalCol).

% movement predicates
move(left, Row, Col, Row, NewCol) :-
    NewCol is Col - 1.

move(right, Row, Col, Row, NewCol) :-
    NewCol is Col + 1.

move(up, Row, Col, NewRow, Col) :-
    NewRow is Row - 1.

move(down, Row, Col, NewRow, Col) :-
    NewRow is Row + 1.

% check if move is valid (in bounds and not wall)
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

% get cell at position
get_cell(Maze, Row, Col, Cell) :-
    nth0(Row, Maze, CurrentRow),
    nth0(Col, CurrentRow, Cell).

% flatten list of lists into single list
flatten([], []).
flatten([[] | Rest], Flat) :-
    flatten(Rest, Flat).
flatten([[Head | Tail] | Rest], [Head | Flat]) :-
    flatten([Tail | Rest], Flat).
flatten([Atom | Rest], [Atom | Flat]) :-
    \+ is_list(Atom),
    flatten(Rest, Flat).
