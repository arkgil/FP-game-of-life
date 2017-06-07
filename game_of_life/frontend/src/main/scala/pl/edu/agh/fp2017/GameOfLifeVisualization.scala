package pl.edu.agh.fp2017

import org.scalajs.dom
import org.scalajs.dom.html.Canvas
import org.scalajs.dom.{Element, console, document}
import pl.edu.agh.fp2017.Board.{Area, Cell}
import pl.edu.agh.fp2017.phoenix.Socket

import scala.scalajs.js.JSApp

object GameOfLifeVisualization extends JSApp {

  import Implicits._

  def main() {
    val canvas: Canvas = document.getElementById("golCanvas")
    val stats: Element = document.getElementById("golStats")

    val renderer = new Renderer(canvas)
    val area = Area(0, 0, 36, 22)

    def enqueueUiUpdateCallback(board: Board, step: Int) {
      dom.window.setTimeout(
        () => {
          stats.innerHTML = s"Automaton step: $step"
          renderer.draw(board, area)
        },
        timeout = 0)
    }

    initWebsocket(enqueueUiUpdateCallback)
  }

  private def initWebsocket(enqueueUiUpdateCallback: (Board, Int) => Unit) {
    val socket = new Socket("/socket")
    socket.connect()

    val channel = socket.channel("visualization")
    channel.join()
      .receive("ok",    resp => console.log("Joined successfully", resp))
      .receive("error", resp => console.log("Unable to join", resp))

    def onNewGeneration(generation: Generation) {
      val cells = generation.cells
        .map(cell => Cell(cell.col, cell.row, cell.state.color))
        .toList

      enqueueUiUpdateCallback(Board(cells), generation.step)
    }

    channel.on("new:generation", onNewGeneration)
  }
}

