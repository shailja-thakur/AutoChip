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

    // Internal signals
    wire B3_active;
    wire B2_active;
    wire B1_active;
    wire B0_active;

    // Check if any of the B states are active
    assign shift_ena = B3_active | B2_active | B1_active | B0_active;

    // Check if the current state is B2
    assign B3_next = (state == 10'b0100); // Active low since it is a next state

    // Determine S_next
    assign S_next = ((state == 10'b0000) && !d) | ((state == 10'b0001) && !d) | ((state == 10'b0110) && !d) | ((state == 10'b1001) && ack);

    // Determine S1_next
    assign S1_next = ((state == 10'b0000) && d);

    // Determine Count_next
    assign Count_next = (state == 10'b0100) | ((state == 10'b0111) && !done_counting);

    // Determine Wait_next
    assign Wait_next = ((state == 10'b0111) && done_counting) | ((state == 10'b1011) && !ack);

    // Check which B states are active
    assign B3_active = (state == 10'b0100);
    assign B2_active = (state == 10'b0010);
    assign B1_active = (state == 10'b0001);
    assign B0_active = (state == 10'b0000);

    // Set done output to 1 if state is Wait
    assign done = (state == 10'b1011);

    // Set counting output to 1 if state is Count
    assign counting = (state == 10'b0111);

endmodule
