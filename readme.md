### example usage (w **imagemagick**):

```
magick in.png in.rgb
zig build run -- in.rgb out.rgb
# you need to know input image size
magick -size XRESxYRES -depth 8 out.rgb out.png 
```

## what does it even do?
takes in rgb image. picks the nearest color in the `clschm` array and replaces the color and makes it look kinda worse. pretty slow (50 lines of code so idk)

## how do i edit the color scheme?
edit `clschm` in `src/main.zig`

## what is the default color scheme in `clschm`?
iom de mia sxatata koloroj de **catppuccin/mocha**

## sample images?
+ ### five pebbies (videocult: rainworld) 
![five pebbies](/images/Pebbles.png)
![five pebbies](/images/pp.png)  
   
   
+ ## from Alena Aenami (`artstation.com/aenamiart`)

![al](/images/al.jpg)
![al](/images/al.png)  