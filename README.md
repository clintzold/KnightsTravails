KNIGHTS TRAVAILS

Program simulates a chessboard using a Graph with connected nodes simulating valid
moves across squares for a Knight chess piece.

Main goal was to calculate the shortest path between two points for a Knight chess piece.

I used Graph terminology such as 'nodes' and 'neighbours' so that code can be recycled 
easily for future projects.


KEY FEATURE

    - #knight_moves is essentially a Breadth First Search of Graph nodes, where a parent map
      of each node is stored in a hash.

    - Parent map is then traversed from final position back to start and points then added to 
      a list

    - List contains shortest path between given nodes(squares) and is printed in reverse order

        ie. #knight_moves([0, 0], [6, 6]) => [[0, 0], [1, 2], [2, 4], [4, 5], [6, 6]]
