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
   return (((this.notes[1] - this.notes[0]) % 24) + 24) % 24;
   }   
   public int secondInterval() {
   return (((this.notes[2] - this.notes[1])  % 24) + 24) % 24;
   }
   
   public int thirdInterval() {
   return (((this.notes[0] - this.notes[2])  % 24) + 24) % 24;
   }
   

    
   //Performs the relative operation
   public void relative() {
      int rt = this.getRoot();
      int t = this.getThird();
      int f = this.getFifth();
      int sint = this.secondInterval();
      this.setRoot(t);
      this.setThird(rt);
      this.setFifth((((rt - sint) % 24) + 24) % 24);
   }
    
    
   //Performs the parallel major/minor operation
   public void parallel() {
     int rt = this.getRoot();
     int t = this.getThird();
     int f = this.getFifth();       
     int fint = this.firstInterval();
     if (fint < 0) {
       fint = (fint + 24) % 24;
     }
     this.setRoot(f);
     this.setFifth(rt);
     this.setThird((((f - fint) % 24) + 24) % 24);
     if (this.getThird() < 0) {
       this.setThird(this.getThird() + 24);
     }
   }
    
   //Performs the leading-tone exchange operation
   public void leadingTone() {     
     int third = this.getThird();
     int fifth = this.getFifth();
     int fint = this.firstInterval();     
     if (fint < 0) {
       fint = (fint + 24) % 24;
     }     
     int sint = this.secondInterval();
     if (sint < 0) {
       sint = (sint + 24) % 24;
     }
     this.setRoot((((fifth + fint) % 24) + 24) % 24);
     this.setThird(fifth);
     this.setFifth(third);
   }
   
  //Performs a mod-2 quartertone shift on the third of a triad
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
  
  //performs a mod-2 quartertone shift on the fifth of a triad
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
  
  
  //Identifies which inversion a triad is (could be jumbled up)
  public int check_subroutine(int i, int j, int k) {
    int interval1 = this.firstInterval();
    int interval2 = this.secondInterval();
    int interval3 = this.thirdInterval();    
    int dummyInterval1 = (((this.getThird() - this.getFifth()) % 24) + 24) % 24;
    int dummyInterval2 = (((this.getRoot() - this.getThird()) % 24) + 24) % 24;
    int dummyInterval3 = (((this.getFifth() - this.getRoot()) % 24) + 24) % 24;
    int flag = 0;
    if ((interval1 == i && interval2 == j && interval3 == k) ) {
      println("root position");
      println("NOTE IS");
      println(this.getRoot());
      flag = 1;
    } else if (dummyInterval1 == i && dummyInterval2 == j && dummyInterval3 == k) {
      println("retrograde root position");
      println("NOTE IS");
      println(this.getFifth());
      flag = 1;
    } else if ((interval1 == j && interval2 == k && interval3 == i)) {
      println("first inversion");
      println("NOTE IS");
      println(this.getFifth());
      flag = 1;
    } else if (dummyInterval1 == j && dummyInterval2 == k && dummyInterval3 == i){
      println("retrograde first inversion");
      println("NOTE IS");
      println(this.getRoot());
      flag = 1;
    } else if ((interval1 == k && interval2 == i && interval3 == j)) {
      println("second inversion");
      println("NOTE IS");
      println(this.getThird());
      flag = 1;
    } else if (dummyInterval1 == k && dummyInterval2 == i && dummyInterval3 == j) {
      println("retrograde second inversion");
      println("NOTE IS");
      println(this.getThird());
      flag = 1;
    }
    return flag;
  }
  
  
  //Checks what type of chord a triad is and prints the result to the console
  public void check() {
    if (this.check_subroutine(8, 6, 10) == 1) {
      println(" + [0 0]");
    } else if (this.check_subroutine(7, 7, 10) == 1) {
      println(" + [-1 0]");
    } else if (this.check_subroutine(8, 5, 11) == 1) {
      println(" + [0 -1]");
    } else if (this.check_subroutine(7, 6, 11) == 1) {
      println(" + [-1 -1]");
    } else if (this.check_subroutine(7, 8, 9) == 1) {
      println(" + [-1 +1]");
    } else if (this.check_subroutine(9, 4, 11) == 1) {
      println(" + [+1 -1]");
    } else if (this.check_subroutine(8, 7, 9) == 1) {
      println(" + [0 +1]");
    } else if (this.check_subroutine(9, 5, 10) == 1) {
      println(" + [+1 0]");
    } else if (this.check_subroutine(9, 6, 9) == 1) {
      println(" + [+1 +1]");
    } else if (this.check_subroutine(6, 8, 10) == 1) {
      println(" - [0 0]");
    } else if (this.check_subroutine(5, 9, 10) == 1) {
      println(" - [-1 0]");
    } else if (this.check_subroutine(6, 7, 11) == 1) {
      println(" - [0 -1]");
    } else if (this.check_subroutine(5, 8, 11) == 1) {
      println(" - [-1 -1]");
    } else if (this.check_subroutine(5, 10, 9) == 1) {
      println(" - [-1 +1]");
    } else if (this.check_subroutine(7, 6, 11) == 1) {
      println(" - [+1 -1]");
    } else if (this.check_subroutine(6, 9, 9) == 1) {
      println(" - [0 +1]");
    } else if (this.check_subroutine(7, 7, 10) == 1) {
      println(" - [+1 0]");
    } else if (this.check_subroutine(7, 8, 9) == 1) {
      println(" - [+1 +1]");
    } else {
      println("not consonant");
    }
      
  }      
}