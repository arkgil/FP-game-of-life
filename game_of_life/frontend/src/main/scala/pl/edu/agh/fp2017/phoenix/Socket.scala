package pl.edu.agh.fp2017.phoenix

import scala.scalajs.js
import scala.scalajs.js.annotation.JSImport

@js.native
@JSImport("phoenix", "Socket")
class Socket(endPoint: String, opts: js.Dynamic = js.Dynamic.literal()) extends js.Object {
  def connect(): Unit = js.native
  def channel(topic: String, chanParams: js.Dynamic = js.Dynamic.literal()): Channel = js.native
}