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

import re
import sys

def fillto9(binary_string) :
  x = ""
  length = 9-len(binary_string)
  for i in range(length):
    x = x+"0"
  return x+binary_string

def fillto10(binary_string) :
  x = ""
  length = 10-len(binary_string)
  for i in range(length):
    x = x+"0"
  return x+binary_string

def getdecimalofcoordinates(x0, y0, x1, y1) :
  print(int(fillto10(bin(x0)[2:])+fillto9(bin(y0)[2:])+fillto10(bin(x1)[2:])+fillto9(bin(y1)[2:]), 2))

def usage():
  print("Usage:\n  python ./image_to_SV_array.py <image name>")

def main():
  if (len(sys.argv) < 5):
    usage()
    return
  x0 = int(sys.argv[1])
  y0 = int(sys.argv[2])
  x1 = int(sys.argv[3])
  y1 = int(sys.argv[4])

  getdecimalofcoordinates(x0,y0,x1,y1)

if __name__ == '__main__':
  main()
