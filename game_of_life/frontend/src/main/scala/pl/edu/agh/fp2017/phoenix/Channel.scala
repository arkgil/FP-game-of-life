package pl.edu.agh.fp2017.phoenix

import scala.scalajs.js
import scala.scalajs.js.annotation.JSGlobal

@js.native
@JSGlobal
class Channel(topic: String, params: js.Dynamic, socket: Socket) extends js.Object {
  def join(): Push = js.native
  def on(event: String, callback: js.Function1[js.Dynamic, Any]): Unit = js.native
}
