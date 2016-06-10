require 'yaml'

class Player
  def self.from_yaml yaml
    yaml.map do |i|
      Player.new(
        name: i[:name],
      )
    end
  end
  def initialize name: 
    @name = name
  end
  def to_s
    "#{@name}"
  end
  def inspect
    to_s
  end
end

class Facility
  TYPE = [
    :blue,
    :atack,
    :green,
    :purple,
  ]

  def self.from_yaml yaml
    yaml.map do |i|
      Facility.new(
        name: i[:name],
        type: i[:type],
      )
    end
  end
  def initialize name:, type:
    @name = name
    @type = type
  end

  def to_s
    "#{@name}:#{@type}"
  end
  def inspect
    to_s
  end
end
class Machikoro
  def initialize facilities: [], players: []
    @facilities = facilities
    @players = players
    @turn = 1
    @faze = [
      :dice,
      :shopping,
    ]
  end
  def start
    puts "facilities=#{@facilities}"
    loop do
      @players.each do |player|
        do_turn(turn_player: player)
        @turn += 1
      end
    end
  end

  def do_turn turn_player:
    puts "turn=#{@turn}"
    puts "player=#{turn_player}"
    puts "Enter to Dice roll!!: "
    gets
    puts [*1..6].sample
  end
end

facilities = Facility.from_yaml(
  YAML.load(<<-EOS
- :name: パン屋
  :type: :green
  :range: !ruby/range 2..3
- :name: カフェ
  :type: :atack
  :range: !ruby/range 2..2
  EOS
  )
)

players = Player.from_yaml(
  YAML.load(<<-EOS
- :name: player1
- :name: player2
- :name: player3
- :name: player4
  EOS
  )
)

machikoro = Machikoro.new(
  facilities: facilities,
  players: players
)

machikoro.start
