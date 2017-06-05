package pl.edu.agh.fp2017

import org.scalajs.dom
import org.scalajs.dom.html.Canvas
import org.scalajs.dom.{Element, console, document}
import pl.edu.agh.fp2017.Board.{Area, Cell}
import pl.edu.agh.fp2017.phoenix.Socket

import scala.scalajs.js.JSApp

object GameOfLifeVisualization extends JSApp {

  import Implicits._

  private var board = Board()
  private var step  = 0

  override def main(): Unit = {
    initWebsocket()

    val canvas: Canvas = document.getElementById("golCanvas")
    val stats: Element = document.getElementById("golStats")

    val renderer = new Renderer(canvas)
    val area = Area(0, 0, 36, 22)

    dom.window.setInterval(
      () => {
        stats.innerHTML = s"Automaton step: $step"
        renderer.draw(board, area)
      },
      timeout = 20)
  }

  private def initWebsocket() = {
    val socket = new Socket("/socket")
    socket.connect()

    val channel = socket.channel("visualization")
    channel.join()
      .receive("ok",    resp => console.log("Joined successfully", resp))
      .receive("error", resp => console.log("Unable to join", resp))

    channel.on("new:generation", (generation: Generation) => {
      val cells = generation.cells
        .map(cell => Cell(cell.col, cell.row, cell.state.color))
        .toList

      step  = generation.step
      board = Board(cells)
    })
  }
}

