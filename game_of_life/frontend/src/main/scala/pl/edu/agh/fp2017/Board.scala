package pl.edu.agh.fp2017

import pl.edu.agh.fp2017.Board.{Area, Cell}

class Board(val aliveCells: List[Cell]) {
  def within(area: Area): Board = {
    val Area(ax, ay, aw, ah) = area
    val aliveCellsWithinArea = aliveCells filter { case Cell(x, y, _) =>
      x >= ax && x < ax + aw && y >= ay && y < ay + ah
    }
    Board(aliveCellsWithinArea)
  }
}

object Board {
  type Color = String

  def apply() = new Board(Nil)
  def apply(aliveCells: List[Cell]) = new Board(aliveCells)

  final case class Cell(x: Int, y: Int, color: Color)
  final case class Area(topLeftX: Int, topLeftY: Int, cols: Int, rows: Int)
}
