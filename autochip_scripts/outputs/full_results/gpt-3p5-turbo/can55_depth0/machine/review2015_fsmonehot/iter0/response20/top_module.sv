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

 always @(state) begin
     B3_next = (state[7] == 1'b1) ? 1'b1 : 1'b0;
     S_next = ((state[9:8] == 2'b00) && (d == 1'b0)) ? 1'b1 : 1'b0;
     S1_next = ((state[9:8] == 2'b01) && (d == 1'b1)) ? 1'b1 : 1'b0;
     Count_next = (state[7] == 1'b1) ? 1'b1 : ((state[6:5] == 2'b01) && (done_counting == 1'b0)) ? 1'b1 : 1'b0;
     Wait_next = (state[5:4] == 2'b10) ? ((state[6:5] == 2'b01) && (done_counting == 1'b1)) ? 1'b1 : ((state[6:5] == 2'b10) && (ack == 1'b0)) ? 1'b1 : 1'b0 : 1'b0;
     done = (state[5:4] == 2'b10) ? ((state[6:5] == 2'b10) && (ack == 1'b1)) ? 1'b1 : 1'b0 : 1'b0;
     counting = (state[7:6] == 2'b01) ? 1'b1 : 1'b0;
     shift_ena = (state[7:4] != 4'b1101) ? 1'b1 : 1'b0;
 end

endmodule
