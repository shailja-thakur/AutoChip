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
    B3_next = (state[2] == 1'b1); // B3_next is 1 only when B2 is active
    S_next = ((state[0] == 1'b1 && d == 1'b0) || (state[1] == 1'b1 && d == 1'b0) || (state[1:0] == 2'b10 && d == 1'b0) || (state[3:0] == 4'b1010 && d == 1'b0) || (state[9:0] == 10'b0000000010 && d == 1'b0 && ack == 1'b1)); // S_next conditions
    S1_next = (state[0] == 1'b1 && d == 1'b1); // S1_next conditions
    Count_next = (state[3] == 1'b1) || (state[9:0] == 10'b0000000001 && done_counting == 1'b0); // Count_next conditions
    Wait_next = (state[9:0] == 10'b0000000010 && ack == 1'b0) || (state[9:0] == 10'b0000000011 && done_counting == 1'b1); // Wait_next conditions
end

assign done = (state[9:0] == 10'b0000000011); // done signal is 1 in Wait state
assign counting = (state[3:0] == 4'b1101); // counting signal is 1 in B3 state
assign shift_ena = (state[3:0] != 4'b0000); // shift_ena is 1 if any of the B3, B2, B1 and B0 states are active

endmodule
