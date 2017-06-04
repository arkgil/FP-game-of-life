enablePlugins(ScalaJSPlugin)

name := "Game of Life Visualization"
version := "1.0.0"
scalaVersion := "2.12.2"

scalaJSModuleKind := ModuleKind.CommonJSModule

scalaJSUseMainModuleInitializer := true

skip in packageJSDependencies := false

libraryDependencies +=
  "org.scala-js" %%% "scalajs-dom" % "0.9.2"

jsDependencies +=
  "org.webjars.npm" % "phoenix-socket" % "1.2.3" / "dist/socket.js"

