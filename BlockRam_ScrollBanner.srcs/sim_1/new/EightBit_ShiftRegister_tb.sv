`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2018 11:26:33 PM
// Design Name: 
// Module Name: EightBit_ShiftRegister_tb
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


module EightBit_ShiftRegister_tb();

//declarations 
logic clk, reset;
logic load_en, shift_en;
logic [1:0]control;
logic [31:0] Din, Dout;



EightBit_ShiftRegister dut
(.clk(clk), .reset(reset), .control(control), 
.load_en(load_en), .shift_en(shift_en),
.Din(Din), .Dout(Dout));
 
//Clock
always 
begin
    clk = 1'b1;
    forever #10 clk =~ clk; 
end 

initial
    begin 
// Other Stimulus
Din = 32'h8fe7291a;
reset = 1'b1;
#30;
reset = 1'b0;
#10
control = 2'b01;
load_en = 1'b1;
#10
control = 2'b10;
shift_en = 1'b1;




//load = 1'b1;
//#10;
//load = 1'b0;
//shift = 1'b1;
    end 
endmodule
