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

    // State definitions
    localparam S = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S11 = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0 = 10'b0000010000;
    localparam B1 = 10'b0000100000;
    localparam B2 = 10'b0001000000;
    localparam B3 = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait = 10'b1000000000;

    // Assign done signal
    assign done = (state == Wait);

    // Assign counting signal
    assign counting = (state == Count);

    // Assign shift_ena signal
    assign shift_ena = (state[B3] | state[B2] | state[B1] | state[B0]);

    // Assign output B3_next
    assign B3_next = state[B2];

    // Assign output S_next
    assign S_next = ((state == S) & !d) | ((state == S1) & !d) | ((state == S110) & !d) | ((state == Wait) & ack);

    // Assign output S1_next
    assign S1_next = (state == S) & d;

    // Assign output Count_next
    assign Count_next = (state == B3) | ((state == Count) & !done_counting);

    // Assign output Wait_next
    assign Wait_next = ((state == Count) & done_counting) | ((state == Wait) & !ack);

endmodule
