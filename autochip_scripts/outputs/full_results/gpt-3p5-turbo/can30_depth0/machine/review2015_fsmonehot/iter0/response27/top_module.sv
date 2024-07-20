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
    B3_next = (state[7]) ? 1'b1 : 1'b0;
    S_next = ((state[9:8] == 2'b00) && (d == 1'b0)) ? 1'b1 : 1'b0;
    S1_next = ((state[9:8] == 2'b01) && (d == 1'b0)) ? 1'b1 : 1'b0;
    Count_next = ((state[7]) || ((state[9:8] == 2'b10) && (done_counting == 1'b0))) ? 1'b1 : 1'b0;
    Wait_next = ((state[7]) || ((state[9:8] == 2'b11) && (ack == 1'b0))) ? 1'b1 : 1'b0;
end

assign done = (state[9:8] == 2'b11) ? 1'b1 : 1'b0;
assign counting = (state[7]) ? 1'b1 : 1'b0;
assign shift_ena = (state[7] || state[6] || state[5] || state[4]) ? 1'b1 : 1'b0;

endmodule
