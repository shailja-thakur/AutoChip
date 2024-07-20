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

always @(*) begin
    B3_next = (state[3] == 1'b1) ? 1'b1 : 1'b0;
    S_next = ((state[0] == 1'b1 && d == 1'b0) || (state[1] == 1'b1 && d == 1'b0) || (state[3] == 1'b1 && d == 1'b0) || (state[9] == 1'b1 && ack == 1'b1)) ? 1'b1 : 1'b0;
    S1_next = (state[0] == 1'b1 && d == 1'b1) ? 1'b1 : 1'b0;
    Count_next = ((state[3] == 1'b1) || (state[8] == 1'b1 && done_counting == 1'b0)) ? 1'b1 : 1'b0;
    Wait_next = ((state[8] == 1'b1 && done_counting == 1'b1) || (state[9] == 1'b1 && ack == 1'b0)) ? 1'b1 : 1'b0;
    
    done = (state[9] == 1'b1) ? 1'b1 : 1'b0;
    counting = (state[8] == 1'b1) ? 1'b1 : 1'b0;
    
    shift_ena = (state[7] == 1'b1 || state[6] == 1'b1 || state[5] == 1'b1 || state[4] == 1'b1) ? 1'b1 : 1'b0;
end

endmodule
