package pl.edu.agh.fp2017

import org.scalajs.dom.CanvasRenderingContext2D
import org.scalajs.dom.html.Canvas
import org.scalajs.dom.raw.Element

import scala.language.implicitConversions
import scala.scalajs.js

object Implicits {
  type Ctx2D = CanvasRenderingContext2D

  implicit def element2Canvas(element: Element): Canvas = element.asInstanceOf[Canvas]

  implicit def dynamic2Ctx2D(dyn: js.Dynamic): Ctx2D = dyn.asInstanceOf[Ctx2D]

  implicit def generationFun2DynamicFun(fun: Generation => Any): js.Function1[js.Dynamic, Any] =
    (data: js.Dynamic) => fun(data.asInstanceOf[Generation])
}
