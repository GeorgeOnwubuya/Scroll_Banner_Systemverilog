`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2018 03:40:50 PM
// Design Name: 
// Module Name: BlockRam_Test
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


module BlockRam_Test();

//Input & Output Declarations
logic clka, clkb, ena, enb, wea;
logic addra;
logic addrb;
logic [15:0]dina;
logic [15:0]doutb;

blk_mem_gen_0 dut (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [0 : 0] addra
  .dina(dina),    // input wire [15 : 0] dina
  .clkb(clkb),    // input wire clkb
  .enb(enb),      // input wire enb
  .addrb(addrb),  // input wire [0 : 0] addrb
  .doutb(doutb)  // output wire [15 : 0] doutb
);

//Clock
always 
begin
    clka = 1'b1;
    clkb = 1'b1;
    #(10/2) clka = 1'b0;
    clkb = 1'b0;
    #(10/2);
end 

initial

    begin
        ena = 1'b1;
        #10;
        addra = 0;
        dina = 16'b10011001;
        wea = 1'b1;
        #10;
        wea = 1'b0;
        #10
        addrb = 0;
        enb = 1'b1;
    end
endmodule
