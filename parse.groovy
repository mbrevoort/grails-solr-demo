def f = new File("Library.xml")
println f.path
def x = new XmlSlurper().parseText(f.text);
//println x.dict
def count=0
x.dict.dict.dict.each {
  //println it.key.find{ it == "Name"}.breadthFirst().size()
  count++
  def i = 0
  def m = [:]
  def label
  it.children().each {
    if(i++ % 2 == 0) {
      label = it     
    } else
      m."${label}" = it
  }
  
  //println "${m.Artist}, ${m.Name}, ${m.Album}"
}

println count