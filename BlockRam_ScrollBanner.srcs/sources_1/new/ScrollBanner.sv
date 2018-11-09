`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2018 04:04:53 PM
// Design Name: 
// Module Name: ScrollBanner
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


module ScrollBanner(
input logic CLK100MHZ, 
input logic Prog_btn1, Prog_btn2,       
input logic Scroll_btn, reset,
input logic [15:0] SW, 
output logic [7:0] AN,
output logic [7:0] sseg,
output logic [15:0]LED
);
        
//State type
typedef enum logic [9:0]{Init = 10'b0000000001, ReadSwitches1 = 10'b0000000010, 
                         ReadSwitches2 = 10'b0000000100, LoadRam1 = 10'b0000001000,  
                         LoadRam2 = 10'b0000010000, Ld_Delay1 = 10'b0000100000, 
                         Ld_Delay2 = 10'b0001000000, Ld_Delay3 = 10'b0010000000, 
                         Load = 10'b0100000000, ScrollData = 10'b1000000000} state_type;

//Signal Declaration
state_type current_state, next_state;
logic  [3:0] num0, num1, num2, num3, num4, num5, num6, num7;
logic ena, enb, wea; 
logic [1:0] addra;
logic addrb;
logic [15:0] dina;
logic [31:0] doutb;
logic [31:0] Din, Dout;  
logic clk_div;
logic max_tick;
logic start, scroll;
logic [1:0] control;
logic clk_div_signal;
logic tick;
logic load_en, shift_en;

//Initialization 
always_ff@(posedge CLK100MHZ, posedge reset)
    begin
        if(reset)
            begin
                current_state = Init;
            end 
        else 
            begin
                current_state = next_state;
            end        
    end

always_comb
begin
    next_state = current_state;
    
    wea = 1'b0;             addra = 2'b00;          dina = 16'h0000;       
    control = 1'b0;         Din = 16'h0000;         clk_div_signal = 1'b0;
    load_en = 1'b0;         addrb = 1'b0;
    LED[6] = Prog_btn1;     LED[8] = Scroll_btn;    LED[5:0] = 6'b000000;   
    LED[14:9] = 6'b000000;  LED[15] = reset;        LED[7] = Prog_btn2;          
    num0 = Dout[3:0];       num1 = Dout[7:4];       num2 = Dout[11:8];            
    num3 = Dout[15:12];     num4 = Dout[19:16];     num5 = Dout[23:20];            
    num6 = Dout[27:24];     num7 = Dout[31:28];     
               
    
    case(current_state)
    Init:
        begin
        LED[0] = 1'b1;   
        load_en = 1;
        control = 2'b01;    
            if(Prog_btn1)
                begin
                    next_state = ReadSwitches1;  
                end
        end
         
    ReadSwitches1:    
        begin
            LED[1] = 1'b1;
            num0 = SW[3:0];
            num1 = SW[7:4];
            num2 = SW[11:8];
            num3 = SW[15:12];
            if(Prog_btn2) 
                begin  
                    next_state = LoadRam1;         
                end                                     
        end
    
    LoadRam1:
        begin
            LED[2] = 1'b1;
            num0 = SW[3:0];
            num1 = SW[7:4];
            num2 = SW[11:8];
            num3 = SW[15:12];
            dina = {SW[15:12], SW[11:8], SW[7:4], SW[3:0]};          
            wea = 1'b1;      
            next_state = ReadSwitches2 ;                                                    
        end
                              
    ReadSwitches2:    
        begin
            LED[1] = 1'b1;
            num0 = doutb[3:0]; 
            num1 = doutb[7:4];       
            num2 = doutb[11:8];            
            num3 = doutb[15:12];
            num4 = SW[3:0];
            num5 = SW[7:4];
            num6 = SW[11:8];
            num7 = SW[15:12];
            if(Scroll_btn) 
                begin  
                    next_state = LoadRam2;         
                end                                     
        end
               
    LoadRam2:
        begin
            LED[2] = 1'b1;
            addra = 2'b01;
            num4 = SW[3:0];
            num5 = SW[7:4];
            num6 = SW[11:8];
            num7 = SW[15:12]; 
            dina = {SW[15:12], SW[11:8], SW[7:4], SW[3:0]};          
            wea = 1'b1; 
            next_state = Ld_Delay1;               
        end    
    
    Ld_Delay1:
        begin
            next_state = Ld_Delay2;    
        end 
     
    Ld_Delay2:
        begin
            next_state = Ld_Delay3;
        end
    
    Ld_Delay3:
                begin
                    next_state = Load;
                end
    
    Load:
        begin
             control = 2'b01;
             load_en = 1'b1;
             next_state = ScrollData;      
        end  
               
    ScrollData:
        begin
            LED[5] = 1'b1; 
            control = 2'b10;
            num0 = Dout[3:0];
            num1 = Dout[7:4];
            num2 = Dout[11:8];
            num3 = Dout[15:12];
            num4 = Dout[19:16];
            num5 = Dout[23:20];
            num6 = Dout[27:24];
            num7 = Dout[31:28];
        end
    default:
                begin
                    next_state = Init;
                end    
    endcase
end    

//Binary Display
Display_8Bit binary_display
(.clk(CLK100MHZ),
 .reset(1'b0),
 .hex7(num7),
 .hex6(num6),
 .hex5(num5),
 .hex4(num4),
 .hex3(num3), 
 .hex2(num2), 
 .hex1(num1),
 .hex0(num0), 
 .an(AN),
 .sseg(sseg)
 );

blk_mem_gen_0 blockRam (
  .clka(CLK100MHZ),    // input wire clka
  .ena(1'b1),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [0 : 0] addra
  .dina(dina),    // input wire [15 : 0] dina
  .clkb(CLK100MHZ),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .addrb(addrb),  // input wire [2 : 0] addrb
  .doutb(doutb)  // output wire [3 : 0] doutb
);

ClockDivder clockdivider(
.clk(CLK100MHZ), 
.reset(reset),
.max_tick(max_tick),
.clk_div(clk_div)
);

EightBit_ShiftRegister shiftreg(
.clk(CLK100MHZ), 
.reset(reset),  
.control(control),
.load_en(load_en),
.shift_en(tick),
.Din(doutb),
.Dout(Dout)
);

EdgeDetect EdgeDetect(
.clk(CLK100MHZ), 
.reset(reset),
.level(clk_div),
.tick(tick)
);

endmodule