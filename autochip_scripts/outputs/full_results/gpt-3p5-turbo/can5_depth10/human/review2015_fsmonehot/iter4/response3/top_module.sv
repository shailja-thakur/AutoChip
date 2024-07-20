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
    output counting,
    output shift_ena
 );
 
 always @(*) begin
    case(state)
        10'b0000000001: S_next = ~d;
        10'b0000000010: S1_next = d;
        10'b1000000000: Wait_next = ~ack;
        10'b0000000100: Count_next = counting & ~done_counting;
        10'b1000000001: Wait_next = ~ack;
        10'b1000000001: done = ack;
        10'b0000000000: B3_next = shift_ena;
    endcase
 end

assign counting = state[8]; 
assign shift_ena = state[6] | state[7] | state[8] | state[9];

endmodule
