require 'pry-byebug'

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

  def add_nodes
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

  def find_neighbours
    self.nodes.each do |key, node|
      x = key[0]
      y = key[1]
      neighbours = [
        [x + 1, y + 2], [x + 1, y - 2], [x - 1, y + 2], [x - 1, y - 2], 
        [x + 2, y + 1], [x + 2, y - 1], [x - 2, y + 1], [x - 2, y + 1]
      ]
      neighbours.each_with_index do |item, index|
        new_x = neighbours[index][0]
        new_y = neighbours[index][1]
        p new_x
        p new_y
        if new_x <= 7 && new_y <= 7 && new_x >= 0 && new_y >= 0
          add_edge([x, y], neighbours[index])
        end
      end
    end
  end

  def add_edge(node_one, node_two)
    @nodes[node_one].add_neighbour(@nodes[node_two])
    @nodes[node_two].add_neighbour(@nodes[node_one])
  end
end


graph = Graph.new
binding.pry

puts 'end'



