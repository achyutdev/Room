/*
*   author - Achyut Dev
*   pov-ray versiotn 3.7 
*
*
*/


 #include "colors.inc"  
 #include "stones.inc"
 #include "textures.inc"
 #include "shapes.inc"
 #include "glass.inc"
 #include "metals.inc"
 #include "woods.inc"
 
 global_settings { ambient_light White }
 global_settings{max_trace_level 10}
 
 
camera {
    location < 0, 12,-25>
    look_at  <0, 0, 0>                     
  } 
  
 //Light source inside room 
 light_source { <-5, 30, -10> 1} 

  background {color rgb <0.2, 0.2, 0.3> }
  
 
 //Room 
 #declare Room = union{    
    
        //Front wall  
        plane{ z,0
          pigment { CadetBlue}
          } 
        
        
        //floor of the room  
        plane{ y,-2
            pigment { 
            //rgb Tan }
            
            image_map
            { gif "floor.gif"
                 map_type 0  
                 interpolate 2
             } 
              
            } 
            finish { reflection 0.1 diffuse 0.8 specular 0.2 }
            
            
            }
               
              
        //Right Wall 
         plane{ x,-10 pigment { rgb <0.2,0.7,0.3> }}
       
                    
         
        //Left Wall 
         plane{ x,15
            pigment { rgb <0.2,0.9,0.4>} 
            }  
         
         //back Wall
        plane{ z,-70
          pigment { CadetBlue} 
            }
        
     } 
  
  
  
  //mirror  
  #declare Mirror = 
  union { 
        box{ <-5, 0,-0.03>, <1, 8,  -0.01>
           pigment { color White }   
           finish { reflection {1.0} ambient 0 diffuse 0 } 
        }  
        
        //wooden mirror frame
        box{<-5-0.15, 0-0.15,-0.02>, <1+0.15, 8+0.15,  0>
            texture {
                 pigment {
                    DMFWood4       // pre-defined in textures.inc
                    scale 2        // scale by the same amount in all
                       // directions
                     }
            finish { Shiny } // pre-defined in finish.inc
                }
            }
        }
 
 union { object {Mirror} object{Room}  }
  
 
 
 //Ball     
   sphere {   <-1,-1,-8>, 1 
       pigment { hexagon Red, Blue, White }
     } 
     
     
   
  
 //Rug 
    box {
        <-3.5, -2,   -10>, <6, -1.95,  -2>
        pigment{
            image_map
            { jpeg "carpet.jpg"
                 map_type 0
                 filter all 0.9
             }
             scale 0.05
        }
     }  
    
  
  
//glass jar 
      
 #declare Glass_Jar = 
 difference{
    cylinder{<1,-1.8,-7>,<1,1 ,-7>,1.4 }
    cylinder{<1,-1.8+0.1,-7>,<1,1+0.1,-7>,1.4*.9}
}


union{ 
 object{  Glass_Jar
        material{
         texture{
          pigment{ rgbf<.98,.98,.98,0.85>*1}
          finish { ambient 0.0
                   diffuse 0.15
                   reflection 0.2
                   specular 0.6
                   roughness 0.005
                   reflection { 0.03, 1.0 fresnel on }
                 }
          }

          interior{ ior 1.5
                    fade_power 1001
                    fade_distance 0.5
                    fade_color <0.8,0.8,0.8>
                  }

 
        }
    }
 
 }  
 
 //water effect
  cylinder{
        <1,-1.8+0.1,-7>,<1,0,-7>,1.4*.9
        material{
          texture{
          pigment{ rgbf<0,.98,.98,0.9>*1}
          normal { ripples 1.35 scale 0.0125 turbulence 0.3 translate<-0.05,0,0> rotate<0,-20,0>} 
          finish { ambient 0.0
                   diffuse 0.15
                   reflection 0.2
                   specular 0.6
                   roughness 0.005
                   phong_size 400
                   reflection { 0.2, 1.0 fresnel on }
                   conserve_energy
                 }
           } 
         
          interior{ ior 1.33 
                    fade_power 1001
                    fade_distance 0.5
                    fade_color <0.8,0.8,0.8> 
                } 
            }
        
        }
        
   //Wall Table
      
        box{  <-10,1.85,-8>,<-6,2,0>
            texture {T_Wood13}
            }
            
         box{  <-10,1,-8>,<-6,1.85,0>
            texture {T_Wood1}
            } 
            
         box{  <-6.5,-2,-8>,<-6,1.85,-7.5>
            texture {DMFDarkOak}
            }
         box{  <-10,-2,-8>,<-9.5,1.85,-7.5>
            texture {DMFDarkOak}
            }   
         box{  <-6.5,-2,-0.5>,<-6,1.85,0>
            texture {DMFDarkOak}
            }
              
        
   //wall photo
    box{ <5.85,7.85,-0.01>, <8.65,11.15,0>
       texture {DMFWood3} 
    }   
    box{ <6,8,-0.02>, <8.5,11,-0.01>
       pigment{ 
            image_map
            { jpeg "achyut.jpg"
                 map_type 0
    
             }
        } 
    }
   
    //chair 1
     
     box{<8,-2,-6>,<8.35,0,-6.35> texture {DMFDarkOak}}
     box{<8,-2,-8>,<8.35,0,-8.35> texture {DMFDarkOak}}
     box{<10,-2,-6>,<10.35,2.25,-6.35> texture {DMFDarkOak}}
     box{<10,-2,-8>,<10.35,2.25,-8.35> texture {DMFDarkOak}}
     box{<10.1,1,-8>,<10.35,2.25,-6.35> texture {T_Wood1}}
     box{<7.95,0,-8.35>,<10.30,0.15,-6.0> texture {T_Wood1}}
     
      
    //chair 2
     union{
         box{<-7,-2,-4>,<-6.65,0,-4.35> texture {DMFDarkOak}}
         box{<-7,-2,-6>,<-6.65,0,-6.35> texture {DMFDarkOak}}
         box{<-5,-2,-4>,<-4.65,2.25,-4.35> texture {DMFDarkOak}}
         box{<-5,-2,-6>,<-4.65,2.25,-6.35> texture {DMFDarkOak}}
         box{<-4.99,1,-6>,<-4.65,2.25,-4.35> texture {T_Wood1}}
         box{<-7.05,0,-6.35>,<-4.70,0.15,-4.0> texture {T_Wood1}} 
         translate 2*z 
         rotate -y*8
     } 
  // My name  
  text {
    ttf "timrom.ttf" "ACHYUT DEV" 0.25, 0
    pigment { MediumOrchid }
    finish { reflection .25 specular 1 }
    translate <6.5,-1.5,-.5> 
    
  }