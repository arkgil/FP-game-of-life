package pl.edu.agh.fp2017

import scala.scalajs.js

@js.native
trait CellState extends js.Object {
  val color: String
}

@js.native
trait CellDesc extends js.Object {
  val col: Int
  val row: Int
  val state: CellState
}

@js.native
trait Generation extends js.Object {
  val step: Int
  val cells: js.Array[CellDesc]
}