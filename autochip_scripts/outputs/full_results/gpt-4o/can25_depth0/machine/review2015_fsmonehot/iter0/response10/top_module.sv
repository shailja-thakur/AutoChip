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

    // Define state one-hot encoding
    // state[0]  - S
    // state[1]  - S1
    // state[2]  - S11
    // state[3]  - S110
    // state[4]  - B0
    // state[5]  - B1
    // state[6]  - B2
    // state[7]  - B3
    // state[8]  - Count
    // state[9]  - Wait

    always @(*) begin
        done = (state[9] == 1'b1); // done signal is 1 in the state Wait
        counting = (state[8] == 1'b1); // counting signal is 1 in the state Count
        shift_ena = (state[4] == 1'b1) || (state[5] == 1'b1) || (state[6] == 1'b1) || (state[7] == 1'b1); // shift_ena is 1 if any of the states B3, B2, B1 and B0 is active
        B3_next = (state[6] == 1'b1); // B3_next is 1 when the state B2 is active
        S_next = ( (state[0] == 1'b1 && d == 1'b0) || (state[1] == 1'b1 && d == 1'b0) || (state[3] == 1'b1 && d == 1'b0) || (state[9] == 1'b1 && ack == 1'b1) ); // S_next is 1 based on given conditions
        S1_next = (state[0] == 1'b1 && d == 1'b1); // S1_next is 1 when the state S and d is 1
        Count_next = (state[7] == 1'b1) || (state[8] == 1'b1 && done_counting == 1'b0); // Count_next is 1 based on given conditions
        Wait_next = (state[8] == 1'b1 && done_counting == 1'b1) || (state[9] == 1'b1 && ack == 1'b0); // Wait_next is 1 based on given conditions
    end

endmodule
