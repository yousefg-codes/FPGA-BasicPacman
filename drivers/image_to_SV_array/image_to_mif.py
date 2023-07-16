'''*****************************************************************************
Original Authors:         Haytham Shaban, Sam Waddell
Modified By:              Timmy Yang, Brenden Page :))
------------------------------------------------------------------------
Project:        image_to_mif.py
------------------------------------------------------------------------
Description:    Image to .mif script that takes in an image and outputs a
                corresponding .mif file to stdout. Has not been tested with non
                .PNG files, and only supports black and white images.
                To save the output to a .mif file, pipe the output into a
                .mif file.
------------------------------------------------------------------------
Requires:       The Pillow image processing library.
*****************************************************************************'''
from PIL import Image
import re
import sys
def fillto8(binary_string) :
  x = ""
  length = 8-len(binary_string)
  for i in range(length):
    x = x+"0"
  return x+binary_string
def img2array(name) :
  img = Image.open(name, 'r')
  mif_file = open("new_mif_rom.mif", "x")
  width = 24
  height = img.size[0]*img.size[1]
  pixelCount = height
  data = list(img.getdata())
  mif_file.write("WIDTH=" + repr(width) + ";")
  mif_file.write("DEPTH=" + repr(height) + ";\n")
  mif_file.write("ADDRESS_RADIX=UNS;")
  mif_file.write("DATA_RADIX=UNS;\n")
  mif_file.write("CONTENT BEGIN")
  for i in range(pixelCount):
    # if(i % width == 0) :
      # if i is divisible by width
    mif_file.write("    ")
    mif_file.write(repr(int((i))) + " \t:  ")
    # if i is near the end of the line
    # if(i % width == width-1) :
    #   f.write(repr(int(data[i][0])))
    # else :
    mif_file.write(repr(int(fillto8(bin(data[i][0])[2:])+fillto8(bin(data[i][1])[2:])+fillto8(bin(data[i][2])[2:]),2))+";\n")
  mif_file.write("END;")
def usage():
  print("Usage:\n  python ./image_to_SV_array.py <image name>")
def main():
  if (len(sys.argv) < 2):
    usage()
    return
  image = sys.argv[1]
  img2array(image)
if __name__ == '__main__':
  main()