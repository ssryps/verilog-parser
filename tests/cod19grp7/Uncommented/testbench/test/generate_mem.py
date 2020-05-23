# -*- coding: UTF-8 -*-

import sys, getopt
import re
import socket
import struct

insts = {'lui', 'ori', 'lwpc'}

def test_pattern():
    patten = re.compile(r'([a-z]+)\s+([$x0-9a-zA-Z]+),\s*([$x0-9a-zA-Z]+)(,\s*([$x0-9a-zA-Z]+))?\s+#')
    text = "    lui  $0, 0xc8ba			# $0=0xc8ba0000"
    text2 = "    ori  $0, $0, 0x2b4b			# $0=0x00002b4b"
    m = patten.search(text2)
    if m:
        print("groups ", m.groups(), '\n')
        tup = m.groups()
        print(m.group(5))
    else:
        print('None')


def reg_to_num(reg_str):
    temp_str = reg_str[1:]
    reg_num = int(temp_str)
    return reg_num

def str_to_int(s):
    if 'x' in s:
        return int(s, 16)
    else:
        return int(s)

def get_lui_inst_hex(rt, immediate):
    tmp_hex = 0b001111 << 26
    reg_num = reg_to_num(rt)
    tmp_hex |= (reg_num << 16)
    tmp_hex |= str_to_int(immediate)
    tmp_hex = socket.htonl(tmp_hex)
    return tmp_hex



def get_ori_inst_hex(rt, rs, immediate):
    tmp_hex = 0b001101 << 26
    rt_num = reg_to_num(rt)
    rs_num = reg_to_num(rs)
    tmp_hex = tmp_hex | (rs_num << 21) | (rt_num << 16) | str_to_int(immediate)
    return socket.htonl(tmp_hex)

def get_lwpc_inst_hex(rs, offset):
    tmp_hex = 0b111011 << 26
    rs_num = reg_to_num(rs)
    tmp_hex = tmp_hex | (rs_num << 21) | (0b01 << 19) | str_to_int(offset)
    return socket.htonl(tmp_hex)

def test_hex():
    temp = 0x12345678
    temp2 = socket.htonl(temp)
    print("{:08x}".format(temp2))
    print(temp2)

def work(argv):
    inputfile = ''
    outputmem = ''
    outputbin = ''
    try:
        opts, _ = getopt.getopt(argv,"hi:m:b:",["ifile=","mfile=","bfile="])
    except getopt.GetoptError:
        print ('generate_mem.py -i <inputfile> -o <outputfile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print ('generate_mem.py -i <inputfile> [-m <output mem file> | -b <output bin file> ]')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-m", "--mfile"):
            outputmem = arg
        elif opt in ("-b", "--bfile"):
            outputbin = arg
    mem_content = ''
    patten = re.compile(r'([a-z]+)\s+([$x0-9a-zA-Z]+),\s*([$x0-9a-zA-Z]+)(,\s*([$x0-9a-zA-Z]+))?\s+#?')
    hex_list = []
    with open(inputfile, 'r') as in_f:
        lines = in_f.readlines()
        for line in lines:
            inst_hex = 0
            m = patten.search(line)
            if m:
                inst_str = m.group(1)
                if inst_str == 'lui':
                    inst_hex = get_lui_inst_hex(m.group(2), m.group(3))
                elif inst_str == 'ori':
                    inst_hex = get_ori_inst_hex(m.group(2), m.group(3), m.group(5))
                elif inst_str == 'lwpc':
                    inst_hex = get_lwpc_inst_hex(m.group(2), m.group(3))
                hex_list.append(inst_hex)
    if(len(outputmem) > 0):
        with open(outputmem, 'w') as out_f:
            for each_hex in hex_list:
                out_f.write("{:08x}".format(each_hex))
                out_f.write("\n")
    if(len(outputbin) > 0):
        with open(outputbin, 'wb') as out_f:
            for each_hex in hex_list:
                out_f.write(struct.pack('>I', each_hex))
def main(argv):
    # test_pattern()
    # test_hex()
    work(argv)

if __name__ == '__main__':
    main(sys.argv[1:])
