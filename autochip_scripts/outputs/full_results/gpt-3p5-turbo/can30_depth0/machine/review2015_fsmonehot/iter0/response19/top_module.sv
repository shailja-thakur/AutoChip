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

 // define state constants
 parameter [9:0] S = 10'b0000000001;
 parameter [9:0] S1 = 10'b0000000010;
 parameter [9:0] S11 = 10'b0000000100;
 parameter [9:0] S110 = 10'b0000001000;
 parameter [9:0] B0 = 10'b0000010000;
 parameter [9:0] B1 = 10'b0000100000;
 parameter [9:0] B2 = 10'b0001000000;
 parameter [9:0] B3 = 10'b0010000000;
 parameter [9:0] Count = 10'b0100000000;
 parameter [9:0] Wait = 10'b1000000000;

 // assign initial values to outputs
 initial begin
   B3_next = 0;
   S_next = 0;
   S1_next = 0;
   Count_next = 0;
   Wait_next = 0;
   done = 0;
   counting = 0;
   shift_ena = 0;
 end

 // logic for output signals
 always @(state, d, ack, done_counting) begin
   B3_next = (state == B2) ? 1'b1 : 1'b0;
   S_next = ((state == S) && (d == 1'b0)) ||
            ((state == S1) && (d == 1'b0)) ||
            ((state == S110) && (d == 1'b0)) ||
            ((state == Wait) && (ack == 1'b1)) ? 1'b1 : 1'b0;
   S1_next = ((state == S) && (d == 1'b1)) ? 1'b1 : 1'b0;
   Count_next = (state == B3) || ((state == Count) && (done_counting == 1'b0)) ? 1'b1 : 1'b0;
   Wait_next = ((state == Count) && (done_counting == 1'b1)) ||
               ((state == Wait) && (ack == 1'b0)) ? 1'b1 : 1'b0;
   done = (state == Wait) ? 1'b1 : 1'b0;
   counting = (state == Count) ? 1'b1 : 1'b0;
   shift_ena = (state == B3) || (state == B2) || (state == B1) || (state == B0) ? 1'b1 : 1'b0;
 end

endmodule
