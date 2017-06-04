package pl.edu.agh.fp2017.phoenix

import scala.scalajs.js
import scala.scalajs.js.annotation.JSGlobal

@js.native
@JSGlobal
class Push(channel: Channel, event: String, payload: js.Dynamic) extends js.Object {
  def receive(status: String, callback: js.Function1[js.Dynamic, Any]): Push = js.native
}
