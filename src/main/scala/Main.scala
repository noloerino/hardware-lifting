import firrtl._
import scala.io.Source

object Main {
  def main(args: Array[String]): Unit = {
    val lfsr: String = {
      val src = Source.fromFile("src/firrtl/lfsr.fir")
      val txt = src.getLines().mkString("\n")
      src.close()
      txt
    }
    val state = CircuitState(firrtl.Parser.parse(lfsr), UnknownForm)
    println(state.circuit.serialize)
  }
}
