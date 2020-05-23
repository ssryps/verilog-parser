import os,sys
import binascii
routing_term=[
    "16.0.0.1/4",
    "32.0.0.1/4",
    "10.0.0.3/4",
    "10.0.0.4/4",
    "64.0.0.2/4",
    "80.0.0.0/4",
    "96.0.0.0/4",
    "112.0.0.0/4",
    "128.0.0.2/4",
    "144.0.0.1/4",
    "160.0.0.1/4",
    "176.0.0.0/4",
    "192.0.0.0/4",
    "208.0.0.0/4",
    "224.0.0.0/4",
    "240.0.0.0/4"
]
with open("tmp.mem","w") as f:
    #f.write("; This .COE file specifies the contents for a block memory of depth=16384, and width=14.\n")
    #f.write("memory_initialization_radix=2;\n")
    #f.write("memory_initialization_vector=\n")
    num = 0
    for item in routing_term:
        mask = int(item.split("/")[1])
        ip = "".join(['{:08b}'.format(int(x)) for x in item.split("/")[0].split(".")])
        s = "00"+"0"*14+"00100"+"01"+ip+"0"
        s_16 = '{:014x}'.format(int(s,2))
        f.write("@"+'{:04x}'.format(num)+" "+s_16+" ")
        num = num+1
    while(num<16384):
        f.write("@"+'{:04x}'.format(num)+" "+"0"*14+" ")
        num=num+1

