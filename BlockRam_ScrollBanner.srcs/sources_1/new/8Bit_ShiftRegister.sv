`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2018 12:12:35 PM
// Design Name: 
// Module Name: 8Bit_ShiftRegister
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


module EightBit_ShiftRegister(
input logic clk, reset,
input logic load_en, shift_en,
input [1:0] control,
input logic [31:0]Din,
output logic [31:0]Dout
);

//Signal Declarations
logic [31:0]temp;

always @(posedge clk, posedge reset)
    begin
        if(reset)
            begin
                temp = 32'h00000000;
            end
        else
        begin
            case(control)
                    2'b00:
                        begin
                            temp = temp;
                        end 
                    2'b01:
                        begin
                            if(load_en)
                            begin
                                temp = Din; 
                            end   
                        end
                    2'b10:
                        begin
                            if(shift_en)
                            begin
                                temp = {temp[27:0], temp[31:28]};  
                            end
                        end  
                    2'b11:
                        begin
                            temp = {temp[3:0], temp[31:4]};
                        end
              endcase                  
        end
    end
    
assign Dout = temp;
endmodule
