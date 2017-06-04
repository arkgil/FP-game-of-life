package pl.edu.agh.fp2017

import org.scalajs.dom
import pl.edu.agh.fp2017.Board.{Area, Cell}

class Renderer(canvas: dom.html.Canvas) {
  type Ctx2D = dom.CanvasRenderingContext2D
  private val ctx = canvas.getContext("2d").asInstanceOf[Ctx2D]

  def draw(board: Board, area: Area) {
    val w = canvas.width  / area.cols
    val h = canvas.height / area.rows

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
