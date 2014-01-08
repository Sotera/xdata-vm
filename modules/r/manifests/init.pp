
class r {
  
  stage { 'r-setup': 
    before => Stage['main'],
  }
  
  class { 'r::source': stage => 'r-setup' }
  
}




