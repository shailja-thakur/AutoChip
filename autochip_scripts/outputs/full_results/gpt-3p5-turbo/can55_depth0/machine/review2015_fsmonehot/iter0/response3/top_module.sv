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
    B3_next = (state == 8'h2);
    S_next = ((state == 8'h1 || state == 8'h3 || state == 8'h7 || state == 8'h9) && d == 0) || (state == 8'h4 && d == 1);
    S1_next = (state == 8'h1 && d == 1);
    Count_next = (state == 8'h6 || (state == 8'h5 && done_counting == 0));
    Wait_next = ((state == 8'h5 && done_counting) || (state == 8'h7 && ack == 0));
    
    done = (state == 8'h9);
    counting = (state == 8'h6);
    shift_ena = (state[3] || state[2] || state[1] || state[0]);
end

endmodule
