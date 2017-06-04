package pl.edu.agh.fp2017

import org.scalajs.dom
import org.scalajs.dom.console
import pl.edu.agh.fp2017.Board.{Area, Cell}
import pl.edu.agh.fp2017.phoenix.Socket

import scala.scalajs.js
import scala.scalajs.js.JSApp
import scala.util.Random

object CaveWebVisualization extends JSApp {
  var board: Board = Board()
  var step: Int = 0

  override def main(): Unit = {
    initWebsocket()

    val canvas = dom.document.getElementById("golCanvas").asInstanceOf[dom.html.Canvas]

    val cells: List[Cell] = List(Cell(0, 0, "green"), Cell(1, 1, "#654321"), Cell(2, 2, "#125634"), Cell(3, 3, "#341256"), Cell(4, 4, "#456123"))
    val area = Area(0, 0, 4, 4)

    val renderer = new Renderer(canvas)

    dom.window.setInterval(() => {
      val mask = Random.shuffle(0x110000 :: 0x001100 :: 0x000011 :: Nil).head
      val newCells = cells map {
        case c: Cell if Random.nextFloat() < 0.8 => c
        case Cell(x, y, oldColStr) =>
          val oldColor = Integer.parseInt(oldColStr.tail, 16)
          val newColor = oldColor ^ mask
          val newColStr = '#' +: newColor.toHexString
          Cell(x, y, newColStr)
      }
      renderer.draw(Board(newCells), area)
    }, 1000)
  }

  private def initWebsocket() = {
    val socket = new Socket("/socket")
    socket.connect()

    val channel = socket.channel("visualization")
    channel.join()
      .receive("ok",    resp => console.log("Joined successfully", resp))
      .receive("error", resp => console.log("Unable to join", resp))

    channel.on("new:generation", data => {
      console.log("dynamic: ", data)

      val generation = data.asInstanceOf[Generation]
      console.log("static: ", generation.generation, generation.cells(0)(0).color, generation.cells(0)(0).region)

      val cells = generation.cells.zipWithIndex.flatMap {
        case (cols, x) => cols.zipWithIndex.map {
          case (state, y) => Cell(x, y, state.color)
        }
      }.toList

      println(cells)
    })
  }
}

@js.native
trait CellState extends js.Object {
  val color: String
  val region: String
}

@js.native
trait Generation extends js.Object {
  val generation: Int
  val cells: js.Array[js.Array[CellState]]
}
