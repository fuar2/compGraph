#include "shapes"
#include "colors"
#include "textures"   
#include "functions.inc"  

#declare FlameTexture = texture {
  pigment {
    function {
      // Используем комбинацию синусов для создания пламени
      sin(y * 10 + x * 2) * 0.5 + sin(z * 5) * 0.5
    }
    color_map {
      [0.0 rgb <0.2, 0.2, 0.0>]   // Темный желтый
      [0.5 rgb <1.0, 0.8, 0.0>]   // Яркий желтый
      [1.0 rgb <1.0, 0.2, 0.0>]   // Красный (в верхней части)
    }
  }
  finish {
    ambient 0.3
    diffuse 0.7
    reflection 0.1
  }
}


#declare GalaxyTexture = pigment {
  function {sin(x*10) + 10*y}
  
  color_map {
    [0.0 rgb <0.2, 0.2, 0.2>]  // Темно-серый
    [0.5 rgb <0.5, 0.5, 0.5>]  // Средний серый
    [1.0 rgb <1.0, 1.0, 1.0>]  // Белый
  }
}

isosurface {
  function { f_spiral(x, y, z, 0.3, 0.1, 1, 0, 0, 2) }
  max_gradient 5
  contained_by { sphere { <0, 0, 0>, 1 } }
  texture { GalaxyTexture }
  rotate <-45, 0, 0>
  translate <-4, 8, 70>
  scale <50, 20, 5>
}
#declare F1 = function{pigment{onion scale 0.5}}
#declare F2 = function{pigment{leopard scale 0.1}}
                    
sphere { <0, 0, 0>, 5  // Определяем центр и радиус сферы
  pigment {
    function {
      F1(x, y, z).grey + F2(x, y, z).grey * 0.5
    }
    color_map {
      [0.0 rgb <1, 0, 0>]
      [0.5 rgb <1, 1, 0>]
      [1.0 rgb <1, 0, 0>]
    }
  }
  translate <60, 52, 70>  // Применяем трансформацию для перемещения сферы
}         






// Определяем функцию для создания сферы
#declare S = function { x*x + y*y + z*z - 1 }

// Определяем текстуру Земли
#declare EarthTexture = texture {
  pigment {
    function {
      // Создаем эффекты океанов и континентов
      (1 - f_noise3d(x * 0.5, y * 0.5, z * 0.5)) * 0.5 + 
      f_noise3d(x * 3, y * 3, z * 3) * 0.5
    }
    color_map {
      [0.0 rgb <0, 0, 1>]  // Темно-синий для океанов
      [0.5 rgb <0.3, 0.8, 0.3>] // Зеленый для континентов
      [1.0 rgb <1, 1, 0>]   // Желтый или светлый цвет
    }
  }
  finish {
    ambient 0.1
    diffuse 0.8
    specular 0.5
    reflection 0.2
  }                    
  
  
}
isosurface {
  function { S(x,y,z) + 
  f_noise3d(x*10, y*10, z*10)*0.3 }
        max_gradient 7
        contained_by{sphere{0,1}}
        pigment {rgb .9} 
        translate <-12, 5,43>    
        texture {
    pigment {
      function {
        // Функция для создания текстуры
        f_noise3d(x * 5, y * 5, z * 5) * 0.3 + sin(sqrt(x*x + y*y + z*z) * 10) * 0.1
      }
      color_map {
        [0.0 rgb <0.2, 0.2, 0.2>]  // Темно-серый цвет
        [0.5 rgb <0.8, 0.8, 0.8>]  // Светло-серый цвет
        [1.0 rgb <1, 1, 1>]        // Белый цвет (для бликов)
      }
    }
    finish {
      ambient 0.2
      diffuse 0.8
      reflection 0.1
    }
  }
        
}

union {
difference {
isosurface {
  function { f_sphere(x,y,z,1) }
  max_gradient 7
  contained_by { sphere { 0, 4 } }
  
  texture { EarthTexture }  // Используем текстуру Земли
  translate <-1, 0, 6>
  scale <8,8, 8>  // Увеличиваем размер в два раза по всем осям
}


sphere {
  // Центр сферы и радиус
  0, 1.2  
  pigment { rgbt <1, 0, 0, 0> }  // Цвет сферы с прозрачностью
  translate <-12, 5, 43>  // Сдвиг сферы
}  }}
      
#declare F=function{pigment{
  crackle 
  turbulence 0.1
  color_map { [0 rgb 1] [1 rgb 0] }
  scale 0.5
  }
}
 
isosurface {
        function { F(x,y,z).red - 0.5 }
        max_gradient 5.5
        contained_by{box{-1,1}}
        pigment {rgb .9}     
        translate <-12, 5, 43> 
        scale <1,1, 1>  
        texture { EarthTexture }
}

#declare Funda=function{pigment{
  crackle 
  turbulence 0.1
  color_map { [0 rgb 1] [1 rgb 0] }
  scale 0.5
  }
}
isosurface {
        function { x*x + y*y +z*z -1
           + Funda(x,y,z).grey*0.3 }
        max_gradient 3.5
        contained_by{sphere{0,1}}
        pigment {rgb .9}             
        translate <2, 5, 43>
        pigment { function {sin(x*30) + sin(y*30)}
    color_map { [0.0 rgb <1,0,0>]
                [0.2 rgb <0,0,1>]
                [0.5 rgb <1,1,0>]
                [0.7 rgb <0,1,0>]
                [1.0 rgb <1,0,0>]
    }
  }
}
#declare Fx = function {u*v*sin(15*v)}
#declare Fy = function {v}
#declare Fz = function {u*v*cos(15*v)}
#declare Fp = function {pigment {granite scale 0.1}}
parametric {
  function {Fx(u,v,0)}
  function {Fy(u,v,0) + Fp(u,v,0).grey*0.2}
  function {Fz(u,v,0)}
      <0,0.1>,<1,1>
  contained_by{box{<-1,-1,-1>,<1,1,1>}}
  precompute 18, x,y,z
  pigment {rgb 0.9}
  finish {phong 0.5 phong_size 10}
  no_shadow  
  scale    <1,2, 1>
  rotate <0, 0, 125>
  translate <4.3, 6.8, 47>  
  texture { FlameTexture }
}      
      
isosurface {
  function { abs(x)+abs(y)+abs(z) - 1 }
        accuracy 0.001
        max_gradient 4
        contained_by{sphere{0,1.2}}
        pigment {rgb .9}
        finish {phong 0.5 phong_size 10}   
        scale    <1,2, 1>
  rotate <0, 0, 125>
  translate <4, 70, 107>    
  texture{GalaxyTexture}
}  








#declare  Sgfdfg = function {x*x + y*y +z*z - 1}
                     
isosurface {
  function { max(Sgfdfg(x+0.5,y,z),S(x-0.5,y,z)) }
        max_gradient 5
        contained_by{sphere{0,1}}
        pigment {rgb .9}
        scale    <1,2, 1>
  rotate <0, 20, 60>
  translate <-16, 30, 57>    
  texture{GalaxyTexture}
}



  
// jupiter
sphere {0,1
       texture {
        pigment {gradient y turbulence .05 frequency -1
                 color_map {
                [0 color rgb <.85,.8,.725>] // poles
                [.05 color rgb <.875,.875,.775>]
                [.15 color rgb <.925,.875,.825>]
                [.25 color rgb <.9,.875,.85>]
                [.275 color rgb <.825,.8,.775>]
                [.33 color rgb <.925,.85,.875>]
                [.45 color rgb <.975,.95,.925>]
                [.54 color rgb <.85,.6,.75>]
                [.55 color rgb <.95,.55,.4>] // Great Red Spot
                [.56 color rgb <.9,.95,.85>]
                [.6 color rgb <.85,.8,.875>]
                [.65 color rgb <.8,.45,.55>]
                [.725 color rgb <.725,.55,.4>] // dark bands
                [.8 color rgb <.725,.575,.425>]
                [.9 color rgb <.85,.7,.725>]
                [.95 color rgb <.75,.725,.775>]
                [1 color rgb <.95,.8,.75>] // equator
                            } scale <.2,1,.2> rotate 15*y translate -.05*y
 warp {black_hole <.5,-.5,-.8>,.25 falloff .3 strength 1.2 turbulence 0 inverse}
                 }
 finish {ambient .03 diffuse .55 phong .075 phong_size 1.5 specular .025 roughness .01}
       }
 scale <1,.91,1>  // still of 1 POV unit size   
 scale 8
           translate <26, 30, 57>
}


  
  

        
        
        
        
        
        
        #declare A = 1;
#declare B = 1;
#declare C = 1;                                

#declare Fxasdasd = function { pow(A * cos(u) * cos(v), 3) };
#declare Fyasdasd = function { pow(B * sin(u) * cos(v), 3) };
#declare Fzasdasd = function { pow(C * sin(v), 3) };

// Определяем размеры коробки
#declare R = 2;

parametric {
  function { Fxasdasd(u, v,0) }
  function { Fyasdasd(u, v,0) }
  function { Fzasdasd(u, v,0) }
  <0, 0>, <2 * pi, pi>  // Устанавливаем диапазоны параметров
  contained_by { box { <-1, -1, -1>, <1, 1, 1> } }
  precompute 18, x, y, z
  texture{FlameTexture} // Цвет фигуры   
      translate <-26, 30, 57>
}
parametric {
  function { Fxasdasd(u, v,0) }
  function { Fyasdasd(u, v,0) }
  function { Fzasdasd(u, v,0) }
  <0, 0>, <2 * pi, pi>  // Устанавливаем диапазоны параметров
  contained_by { box { <-1, -1, -1>, <1, 1, 1> } }
  precompute 18, x, y, z
  texture{FlameTexture} // Цвет фигуры   
      translate <-26, 20, 57>
}
parametric {
  function { Fxasdasd(u, v,0) }
  function { Fyasdasd(u, v,0) }
  function { Fzasdasd(u, v,0) }
  <0, 0>, <2 * pi, pi>  // Устанавливаем диапазоны параметров
  contained_by { box { <-1, -1, -1>, <1, 1, 1> } }
  precompute 18, x, y, z
  texture{FlameTexture} // Цвет фигуры   
      translate <26, 10, 57>
}
parametric {
  function { Fxasdasd(u, v,0) }
  function { Fyasdasd(u, v,0) }
  function { Fzasdasd(u, v,0) }
  <0, 0>, <2 * pi, pi>  // Устанавливаем диапазоны параметров
  contained_by { box { <-1, -1, -1>, <1, 1, 1> } }
  precompute 18, x, y, z
  texture{FlameTexture} // Цвет фигуры   
      translate <-46, 10, 57>
}
parametric {
  function { Fxasdasd(u, v,0) }
  function { Fyasdasd(u, v,0) }
  function { Fzasdasd(u, v,0) }
  <0, 0>, <2 * pi, pi>  // Устанавливаем диапазоны параметров
  contained_by { box { <-1, -1, -1>, <1, 1, 1> } }
  precompute 18, x, y, z
  texture{FlameTexture} // Цвет фигуры   
      translate <-36, 20, 57>
}






      
      
      
      
      


background{  
rgb<0,0,0> 
}camera{          //front           //back                //side
	location <0,5,-30>       /* <-25,5,35>*/        // <-35,5,-30>
        look_at <0,5,0>   /*    <0,5,0> */
}light_source{ 
	<40, 40, 50>
        color White}


