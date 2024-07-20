module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

reg B3_next, S_next, S1_next, Count_next, Wait_next, done, counting, shift_ena;

always @(*) begin
    B3_next = (state[4]) ? 1'b1 : 1'b0;
    S_next = ((state[8] && ~d) || (state[6] && ~d) || (state[2] && ~d) || (state[0] && ack)) ? 1'b1 : 1'b0;
    S1_next = (state[8] && d) ? 1'b1 : 1'b0;
    Count_next = (state[4] || (state[1] && ~done_counting)) ? 1'b1 : 1'b0;
    Wait_next = ((state[1] && done_counting) || (state[0] && ~ack)) ? 1'b1 : 1'b0;
    done = (state[0]) ? 1'b1 : 1'b0;
    counting = (state[1]) ? 1'b1 : 1'b0;
    shift_ena = (state[4] || state[3] || state[2] || state[1]) ? 1'b1 : 1'b0;
end

assign B3_next = B3_next;
assign S_next = S_next;
assign S1_next = S1_next;
assign Count_next = Count_next;
assign Wait_next = Wait_next;
assign done = done;
assign counting = counting;
assign shift_ena = shift_ena;

endmodule
