`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2018 09:38:20 PM
// Design Name: 
// Module Name: ClockDivder
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

module ClockDivder(
input logic clk, reset,
output logic clk_div, max_tick
    );

//define constant number  for counts    
localparam constNumber = 50000000;
//localparam constNumber = 50;

//signal declaration
logic [31:0]count;      
    
always @ (posedge(clk), posedge(reset))
begin
    if (reset == 1'b1)
    begin
        count <= 32'b0;
        max_tick <= 1'b0;
    end
    else if (count == constNumber - 1)
    begin
        count <= 32'b0;
        max_tick <= 1'b1;
    end
    else
    begin
        count <= count + 1;
        max_tick <= 1'b0;
    end
end

always @ (posedge(clk), posedge(reset))
begin
    if (reset == 1'b1)
        clk_div <= 1'b0;
    else if (count == constNumber - 1)
        clk_div <= ~clk_div;
    else
        clk_div <= clk_div;
end    
endmodule
