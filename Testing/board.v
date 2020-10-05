//yigit suoglu
//board file
`include "Source/divider_param.v"
`include "Source/divider_8bit.v"
`include "Testing/debouncer.v"
`include "Testing/ssd_util.v"
`timescale 1ns / 1ps
`timescale 1ns / 1ps

module board(clk, btnC, btnU, sw, led, seg, an);
input clk, btnC, btnU; //clock, start, reset
input [15:0] sw; //{dividend, divisor}
output [15:0] led;
output [6:0] seg; //gfedcba
output [3:0] an;
wire rst, strt, not_valid, idle;
wire [7:0] dividend, divisor, quotient, remainder;
wire a, b, c, d, e, f, g;

assign rst = btnU;
assign dividend = sw[15:8];
assign divisor = sw[7:0];
assign seg = {g, f, e, d, c, b, a};
assign led = {14'b0, not_valid, idle};

ssdMaster ssdDriver(clk, rst, 4'b1111, remainder[3:0], remainder[7:4], quotient[3:0], quotient[7:4], a, b, c, d, e, f, g, an);
debouncer dbunce(clk, rst, btnC, strt);
divider_8bit uut(clk, rst, strt, dividend, divisor, quotient, remainder, not_valid, idle);
    
endmodule//board
