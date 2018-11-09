`timescale 1ns / 1ps
module Scroll_Stopwatch(
    input clock,
    input reset
);    

//Signal Declarations
logic [3:0] clickcount; //register to hold the count upto 9. That is why a 4 bit register is used. 3 bit would not have been enough.
logic [28:0] ticker; 
logic click; 

always @ (posedge clock or posedge reset) //always block for the ticker
begin
 if(reset)
  ticker <= 0;
 else if(ticker == 50000000) //reset after 1 second
  ticker <= 0;
 else
  ticker <= ticker + 1;
end
 
 
assign click = ((ticker == 50000000)?1'b1:1'b0); //click every second
 
always @ (posedge click or posedge reset)
begin
 if(reset)
  clickcount <= 0;
 else if(clickcount == 8)
   clickcount <= 0;
  else
  clickcount <= clickcount + 1;
 
end
endmodule