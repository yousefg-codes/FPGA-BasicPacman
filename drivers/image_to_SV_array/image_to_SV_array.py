'''*******************************************************************************
    Authors:         Haytham Shaban, Sam Waddell
    ------------------------------------------------------------------------
    Project:        image_to_SV_array.py
    ------------------------------------------------------------------------
    Description:    Image to Array Script that takes in an image, and produces the verilog assignments required to produce the same image on a VGA display.
    ------------------------------------------------------------------------
*******************************************************************************'''

from PIL import Image
import re
import sys

def img2array(name) :
    img = Image.open(name, 'r');
    width, height = img.size;
    pixelCount = width*height;
    data = list(img.getdata());
    #print(data);
        
    for i in range(pixelCount):  
        if(i % width == 0) :
            if(i != 0) :
                print("};");
            print("array[%d] = " % (i/width), end =" "),; ####### Change "array" to whatever name you want for the logic that will be assigned.
            print("{", end =" "),;
        
        #print(re.sub(r"(\d$)", r"\1,",re.sub('[()]',"",str(data[i][3]))), end =" "),; #previous, now unused print statement
        if(i % width == width-1) :
            print("24'b" + str(bin(data[i][0])), end =" "),;
        else :
            print("24'b" + str(bin(data[i][0]))+ ",", end =" "),;
    print("};");    
    

def main():
  if (len(sys.argv) < 2):
    usage()
    return
  image = sys.argv[1]

  img2array(image)

if __name__ == '__main__':
  main()