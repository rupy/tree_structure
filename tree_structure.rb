require 'yaml'

#
#= 木のノード
#
class Node

  attr_accessor :data, :children

  # 初期化
  def initialize(data = nil)
    @data = data
    @children = []
  end

  # 木構造の作成
  def create(y)
    # key #=> データ
    # value #=> 子供の木の配列
    y.each do |key, value|
      @data = key
      value.each do |v|
        child = Node.new
        @children.push child
        if v.instance_of?(Hash)
          child.create(v)
        elsif v.instance_of?(Fixnum)
          child.data = v
        end
      end
    end
  end

  # ノードの表示
  def printData(depth)
    puts @data
    @children.each do |child|
      depth.times do print " " end
      child.printData(depth + 1)
    end
  end

  def findData(data)
    if @data == data
      return true
    else
      @children.each do |child|
        if child.findData(data)
          return true
        end
      end
    end
    return false
  end

end

#
#= 木構造を構成するクラス
#
class MyTree

  # 初期化
  def initialize()
    @root = nil
  end

  # ノードの追加
  def createTreeByYAML(yml)
    y = YAML.load(yml)
    @root = Node.new
    @root.create(y)
  end

  # 木構造のプリント
  def printTree
    @root.printData(1)
  end

  def findNode(data)
    @root.findData(data)
  end
end

tree = MyTree.new

yml = <<YML
2:
  - 3
  - 4
  - 5
  - 6:
    - 7
    - 8
    - 9
YML

tree.createTreeByYAML(yml)
tree.printTree
data = 3
if tree.findNode(data)
  puts "#{data}が見つかりました"
else
  puts "#{data}が見つかりません"
end