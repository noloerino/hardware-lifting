name := "hardware-lifting"

version := "0.1"

scalaVersion := "2.13.5"

libraryDependencies += "edu.berkeley.cs" %% "firrtl" % "1.4.2"

mainClass in (Compile, run) := Some("Main")
