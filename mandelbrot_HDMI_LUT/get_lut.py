import numpy as np


def step(z,c,p):
    return np.power(z,p)+c

def rollout(c,p,lim=255):
    z = c
    k = 1
    while (np.abs(z) < 2)and(k < 256):
        z = step(z,c,p)
        k+=1
    return int(255.0 * np.log(k) / np.log(256))

def outrow(a,b,c):
    abin = format(a, '010b')
    bbin = format(b, '010b')
    cbin = format(c, '08b')

    return "20'b" + abin + bbin + " : " + "m = 8'b" + cbin + ";\n"

file = open('mandebrot_lut.v', 'w')
file.write("module mandelbrot_lut (\n")
file.write("    input [9:0] i,\n")
file.write("    input [9:0] j,\n")
file.write("    output reg [7:0] m\n")
file.write("  );\n")
file.write(" \n")
file.write("  always @(i,j) begin\n")
file.write("    case({i,j})\n")
for j in range(0,480,1):
    for i in range(0,640,1):
        x = -2.5 + (4.0 * i) / 640
        y = -1.5j + (3.0j * j) / 480
        mandout = rollout(x+y,2.0)
        file.write("      " + outrow(i, j, mandout))
file.write("      default : m = 8'b00000000;\n")
file.write("    endcase\n")
file.write("  end\n")
file.write("endmodule\n")

