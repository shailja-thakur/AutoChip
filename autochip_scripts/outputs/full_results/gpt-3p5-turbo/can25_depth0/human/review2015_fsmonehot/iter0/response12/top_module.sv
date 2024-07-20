module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );
         
     always @* begin
         case(state)
             10'b0000000001: begin    // S
                 S_next = (d == 1) ? 10'b0000000010 : 10'b0000000001;
                 S1_next = 10'b0000000001;
                 Count_next = 10'b0000000000;
                 Wait_next = (done == 1 && ack == 1) ? 10'b0000000000 : 10'b0000000001;
                 B3_next = 10'b0000000000;
             end
             
             10'b0000000010: begin    // S1
                 S_next = 10'b0000000001;
                 S1_next = (d == 1) ? 10'b0000000100 : 10'b0000000010;
                 Count_next = 10'b0000000000;
                 Wait_next = 10'b0000000000;
                 B3_next = 10'b0000000000;
             end
             
             10'b0000000100: begin    // S11
                 S_next = 10'b0000000010;
                 S1_next = (d == 1) ? 10'b0000000100 : 10'b0000000010;
                 Count_next = 10'b0000000000;
                 Wait_next = 10'b0000000000;
                 B3_next = 10'b0000000000;
             end
             
             10'b0000001000: begin    // S110
                 S_next = 10'b0000000010;
                 S1_next = (d == 1) ? 10'b0000000100 : 10'b0000000010;
                 Count_next = 10'b0000000000;
                 Wait_next = 10'b0000000000;
                 B3_next = (d == 1) ? 10'b1000000000 : 10'b0000000000;
             end
             
             10'b1000000000: begin    // B0
                 S_next = 10'b0000000000;
                 S1_next = 10'b0000000000;
                 Count_next = 10'b0000000010;
                 Wait_next = 10'b0000000000;
                 B3_next = 10'b0000000000;
             end
             
             10'b0000000000: begin    // Count
                 S_next = 10'b0000000000;
                 S1_next = 10'b0000000000;
                 Count_next = (done_counting == 0) ? 10'b0000000000 : 10'b0000000100;
                 Wait_next = (done_counting == 0) ? 10'b0000000001 : 10'b0000000000;
                 B3_next = 10'b0000000000;
             end
             
             10'b0000000011: begin    // Wait
                 S_next = (ack == 1) ? 10'b0000000001 : 10'b0000000011;
                 S1_next = 10'b0000000000;
                 Count_next = 10'b0000000000;
                 Wait_next = 10'b0000000000;
                 B3_next = 10'b0000000000;
             end
             
             default: begin
                 S_next = 10'b0000000000;
                 S1_next = 10'b0000000000;
                 Count_next = 10'b0000000000;
                 Wait_next = 10'b0000000000;
                 B3_next = 10'b0000000000;
             end
         endcase
     end

     always @* begin
         done = (state == 10'b0000000011) && (ack == 0);
         counting = (state == 10'b0000000000) && (done_counting == 0);
         shift_ena = (state >= 10'b1000000000);
     end
 
 endmodule
