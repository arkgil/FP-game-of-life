package pl.edu.agh.fp2017

import org.scalajs.dom
import pl.edu.agh.fp2017.Board.{Area, Cell}

import scala.math.min

class Renderer(canvas: dom.html.Canvas) {

  import Implicits._

  private val ctx: Ctx2D = canvas.getContext("2d")

  def draw(board: Board, area: Area) {
    val w = min(canvas.width / area.cols, canvas.height / area.rows)
    val h = min(canvas.width / area.cols, canvas.height / area.rows)

    def drawCell(cell: Cell) {
      val Cell(x, y, color) = cell
      ctx.fillStyle = color
      ctx.fillRect(x * w, y * h, w, h)
    }

    def clearArea() {
      val Area(x, y, cols, rows) = area
      ctx.clearRect(x, y, w * cols, h * rows)
    }

    clearArea()
    (board within area).aliveCells foreach drawCell
  }
}
