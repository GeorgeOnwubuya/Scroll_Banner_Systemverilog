`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2018 10:03:53 AM
// Design Name: 
// Module Name: ScrollBanner_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ScrollBanner_tb();

logic CLK100MHZ, reset;   
logic Prog_btn1, Prog_btn2, Scroll_btn;
logic [15:0] SW; 
logic [7:0] AN;
logic [7:0] sseg;
logic [15:0]LED;

ScrollBanner dut(
.CLK100MHZ(CLK100MHZ),
.reset(reset), 
.Prog_btn1(Prog_btn1),
.Prog_btn2(Prog_btn2),       
.Scroll_btn(Scroll_btn), 
.SW(SW), 
.AN(AN),
.sseg(sseg),
.LED(LED)
//output logic shift_enable
);

always 
begin
    CLK100MHZ = 1'b1;
    #(10/2) CLK100MHZ = 1'b0;
    #(10/2);
end 

initial
    begin
         Prog_btn1 = 1'b0;
         Prog_btn2 = 1'b0;
         Scroll_btn = 1'b0;
         reset = 1'b1;
         #10;
         reset = 1'b0;
         #10
         
         Prog_btn1 = 1'b1;
         #10
         Prog_btn1 = 1'b0;
         SW = 16'hfeff;
         #10;
         Prog_btn2 = 1'b1;
         SW = 16'h1890;
         #10;
         Prog_btn2 = 1'b0;
         #10;
         Scroll_btn = 1'b1;
         
    end
endmodule
