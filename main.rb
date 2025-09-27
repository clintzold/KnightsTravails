
class GraphNode

  attr_accessor :data, :neighbours, :visited

  def initialize(data)
    @data = data
    @neighbours = []
    @visited = false
  end

  def add_neighbour(neighbour)
    #Prevents duplicate edges from being added to adjacency list(@neighbours)
    return if @neighbours.include?(neighbour) 
    @neighbours << neighbour
  end

end


class Graph

  attr_accessor :nodes

  def initialize
    @nodes = {}
  end

  def build_board
    x = 0
    y = 0
    64.times do 
      position = [x, y]
      @nodes[position] = GraphNode.new(position)
      x += 1
      y += 1 if x > 7
      x = 0 if x > 7
    end
  end
  
  #For each square(node), finds squares within a valid 'Knight' chess move away and creates an edge between them
  def find_moves
    self.nodes.each do |key, node|
      x = key[0]
      y = key[1]
      #Build array of possible moves
      neighbours = [
        [x + 1, y + 2], [x + 1, y - 2], [x - 1, y + 2], [x - 1, y - 2], 
        [x + 2, y + 1], [x + 2, y - 1], [x - 2, y + 1], [x - 2, y + 1]
      ]
      #Checks calculated coordinates of neighbours and adds them if valid
      neighbours.each_with_index do |item, index|
        new_x = neighbours[index][0]
        new_y = neighbours[index][1]
        #Adds edges to squares if valid(don't fall beyond capacity of 'board')
        if new_x <= 7 && new_y <= 7 && new_x >= 0 && new_y >= 0
          add_edge([x, y], neighbours[index])
        end
      end
    end
  end
  
  #Creates an undirected edge between nodes/squares
  def add_edge(node_one, node_two)
    @nodes[node_one].add_neighbour(@nodes[node_two])
    @nodes[node_two].add_neighbour(@nodes[node_one])
  end

  #Finds shortest path of valid moves to a given square
  def knight_moves(start, final)
    #List to store resolved 
    parent_map = {}

    #Queue for BFS
    queue = []

    #Mark starting node as visited
    self.nodes[start].visited = true
    #Enqueue starting node
    queue << start
    #Begins deque and exploration process
    while queue.empty? == false
      curr = queue.shift
      #Once final node is visited, reconstructs and returns shortest path to final node
      if curr == final
        shortest_path = []
        #Traverses parent map in reverse order from final node and builds shortest path
        while !parent_map[curr].nil?
          shortest_path << curr
          curr = parent_map[curr]
        end
        #Reset visited status of nodes so #knight_moves operation can be performed again
        self.nodes.each {|node| node[1].visited = false}
        #Because start node has no parent it is added manually as the final position in the reverse path
        shortest_path << start
        #Reverses the order of the shortest path from final node to starting node
        return p shortest_path.reverse
      end

      #Get all neighbours of current node and store them in queue
      self.nodes[curr].neighbours.each do |neighbour|
        #Checks only unvisited nodes
        if neighbour.visited == false
          #Adds unexplored node to the queue(using just the data of node, as it also corresponds to key in Graph @nodes hash)
          queue << neighbour.data
          #Adds current node as parent to its neighbour in parent map(allows for reconstruction of shortest path)
          parent_map[neighbour.data] = self.nodes[curr].data
          #Marks neighbour as visited to prevent looping cycle
          neighbour.visited = true
        end
      end
    end
  end
end

graph = Graph.new
graph.build_board
graph.find_moves
graph.knight_moves([0, 0], [6, 6]) #Outputs => [[0, 0], [1, 2], [2, 4], [4, 5], [6, 6]]

