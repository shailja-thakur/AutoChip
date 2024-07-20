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
    output done,
    output counting,
    output shift_ena
 );
 
 reg done;
 reg counting;
 
 assign done = (state == 10'b0_0001_0000) ? 1'b1 : 1'b0;
 assign counting = (state == 10'b0_0000_0100) ? 1'b1 : 1'b0;
 assign shift_ena = (state[3] || state[4] || state[5] || state[6]) ? 1'b1 : 1'b0;
 
 always @(*) begin
    B3_next = (state == 10'b0_0010_0000) ? 1'b1 : 1'b0;
    S_next = ((state == 10'b0_0000_0001) && !d) || ((state == 10'b0_0000_0010) && !d) || ((state == 10'b0_1000_0000) && !d) || ((state == 10'b0_0001_0000) && ack) ? 1'b1 : 1'b0;
    S1_next = ((state == 10'b0_0000_0001) && d) ? 1'b1 : 1'b0;
    Count_next = ((state == 10'b0_0010_0000) || ((state == 10'b0_0000_0100) && !done_counting)) ? 1'b1 : 1'b0;
    Wait_next = (((state == 10'b0_0000_0100) && done_counting) || ((state == 10'b0_0001_0000) && !ack)) ? 1'b1 : 1'b0;
 end
 
 endmodule
