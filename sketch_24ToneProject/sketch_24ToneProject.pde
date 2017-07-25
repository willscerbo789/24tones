import java.util.Arrays;


class Triad {
  
  public final int[] notes = new int[3];
  public int type;
  public final int[] qtones = new int[2];
  public int[] qs = new int[2];
  
  
  //constructor for triad
  //note names and chord type(major = 1, minor = 0) and quarter tone tuple (+/- 1, +/- 1)
  public Triad(int root, int type, int tone1, int tone2) {
    this.notes[0] = root % 24;
    this.type = type;
    if (type == 1) 
    {
      this.notes[1] = (root + 8 + tone1) % 24;
      this.notes[2] = (root + 14 + tone2) % 24;
    }
    else
    {
      this.notes[1] = (root + 6 + tone1) % 24;
      this.notes[2] = (root + 14 + tone2) % 24;
    }
    
    this.qtones[0] = tone1;
    this.qtones[1] = tone2;
    
  }
  
  
  //getters and setters
  public int getType() {
   return this.type; 
  }  
  public void setType(int i) {
    this.type = i; 
  }  
  public int getQTone1() {
    return this.qtones[0];  
  }  
  public int getQTone2() {
    return this.qtones[1];
  }  
  public void setQTone1(int i) {
     this.qtones[0] = i; 
  }  
  public void setQTone2(int i) {
    this.qtones[1] = i; 
  }      
   public int getRoot() {
    return (this.notes[0] % 24);
  }    
   public void setRoot(int r) {
    this.notes[0] = r;
   }                                              
   public int getThird() {
    return (this.notes[1] % 24);
   }   
   public void setThird(int t) {
   this.notes[1] = t;
   }  
   public int getFifth() {
    return (this.notes[2] % 24);
   }   
   public void setFifth(int f) {
   this.notes[2] = f; 
   }   
   public int firstInterval() {
   return (this.notes[1] - this.notes[0]) % 24;
   }   
   public int secondInterval() {
   return (this.notes[2] - this.notes[1]) % 24;
   }
   
   public boolean triadCompare(Triad t) {
     if ((t.getRoot() == this.getRoot()) && (t.getThird() == this.getThird()) && (t.getFifth() == this.getFifth())) {
       return true;
     } else {
       return false;
     }     
   }
    
   public void relative() {
      int rt = this.getRoot();
      int fint = this.firstInterval();
      int sint = this.secondInterval();
      this.setRoot((((rt + (2*fint) + sint) % 24) + 24) % 24);
      this.setThird((((rt + fint + sint) % 24) + 24) % 24);
      this.setFifth((((rt + fint) % 24) + 24) % 24);
   }
    
   public void parallel() {
     int rt = this.getRoot();
     int t = this.getThird();
     int f = this.getFifth();       
     int fint = this.firstInterval();
     if (fint < 0) {
       fint = (fint + 24) % 24;
     }

     this.setRoot(((rt) + 24) % 24);
     this.setThird((((f - fint) % 24) + 24) % 24);
     this.setFifth(((f) + 24) % 24);
     //approximation
     if (fint <= 4) {
       this.setThird((t + fint) % 24);
     }
     
     if (this.getThird() < 0) {
       this.setThird(this.getThird() + 24);
     }

   }
    
   public void leadingTone() {
     
     int root = this.getRoot();
     int fint = this.firstInterval();
     if (fint < 0) {
       fint = (fint + 24) % 24;
     }
     int sint = this.secondInterval();
     if (sint < 0) {
       sint = (sint + 24) % 24;
     }
     this.setRoot((((root - sint) % 24) + 24) % 24);
     this.setThird((((root) % 24) + 24) % 24);
     this.setFifth((((root + fint) % 24) + 24) % 24);

   }
   
  public void microShift1(int i) {
    //println(this.getQTone1());
    int t = this.getThird();
    if (i == 1) {
      if (this.getQTone1() == -1) {
        this.setThird((((t+1)%24)+24)%24);
        this.setQTone1(0);
      } else if (this.getQTone1() == 0) {
        this.setThird((((t+1)%24)+24)%24);
        this.setQTone1(1);
      } else if (this.getQTone1() == 1) {
        this.setThird((((t-2)%24)+24)%24);
        this.setQTone1(-1);
      }
    } else if (i == -1) {
      if (this.getQTone1() == -1) {
        this.setThird((((t+2)%24)+24)%24);
        this.setQTone1(1);
      } else if (this.getQTone1() == 0) {
        this.setThird((((t-1)%24)+24)%24);
        this.setQTone1(-1);
      } else if (this.getQTone1() == 1) {
        this.setThird((((t-1)%24)+24)%24);
        this.setQTone1(0);
      }  
    }
  }
  
  public void microShift2(int j) {
    
    int f = this.getFifth();
    if (j == -1) {
        if (this.getQTone2() == -1) {
          this.setFifth((((f+2)%24)+24)%24);
          this.setQTone2(1);
        } else if (this.getQTone2() == 0) {
          this.setFifth((((f-1)%24)+24)%24);
          this.setQTone2(-1);
        } else if (this.getQTone2() == 1) {
          this.setFifth((((f-1)%24)+24)%24);
          this.setQTone2(0);
        }
    } else if (j == 1) {
        if (this.getQTone2() == -1) {
          this.setFifth((((f+1)%24)+24)%24);
          this.setQTone2(0);
        } else if (this.getQTone2() == 0) {
          this.setFifth((((f+1)%24)+24)%24);
          this.setQTone2(1);
        } else if (this.getQTone2() == 1) {
          this.setFifth((((f-2)%24)+24)%24);
          this.setQTone2(-1);
        }
    }
  }
   
   
}