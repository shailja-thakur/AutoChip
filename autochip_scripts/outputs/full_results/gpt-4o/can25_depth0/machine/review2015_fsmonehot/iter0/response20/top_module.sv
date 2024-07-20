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

    // State encoding for better readability
    localparam S = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S11 = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0 = 10'b0000010000;
    localparam B1 = 10'b0000100000;
    localparam B2 = 10'b0001000000;
    localparam B3 = 10'b0010000000;
    localparam COUNT = 10'b0100000000;
    localparam WAIT = 10'b1000000000;

    // Output logic
    assign done = (state[9] == 1'b1); // done = 1 in the state Wait
    assign counting = (state[8] == 1'b1); // counting = 1 in the state Count
    assign shift_ena = (state[7] == 1'b1 || state[6] == 1'b1 || state[5] == 1'b1 || state[4] == 1'b1); // shift_ena = 1 in states B3, B2, B1, B0
    assign B3_next = (state[6] == 1'b1); // B3_next = 1 when the state B2 is active
    assign S_next = ((state[0] == 1'b1 && d == 1'b0) || (state[1] == 1'b1 && d == 1'b0) || (state[3] == 1'b1 && d == 1'b0) || (state[9] == 1'b1 && ack == 1'b1)); // S_next logic
    assign S1_next = (state[0] == 1'b1 && d == 1'b1); // S1_next = 1 when the state S and d is 1
    assign Count_next = (state[7] == 1'b1 || (state[8] == 1'b1 && done_counting == 1'b0)); // Count_next logic
    assign Wait_next = ((state[8] == 1'b1 && done_counting == 1'b1) || (state[9] == 1'b1 && ack == 1'b0)); // Wait_next logic

endmodule
