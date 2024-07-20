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

    // State transition logic
    assign B3_next = (state == 10'b0111111111);   // Transition to B3 if current state is B2
    assign S_next = (state == 10'b0000000001);    // Transition to S if current state is B3
    assign S1_next = (state == 10'b0000000010);   // Transition to S1 if current state is S
    assign Count_next = (state == 10'b1000000000) ? !done_counting : state[9];   // Transition to Count if current state is B3 and done_counting is not set, otherwise stay in Count
    assign Wait_next = (state == 10'b1000000100) ? ack : state[9];   // Transition to Wait if current state is B3 and ack is set, otherwise stay in Wait

    // Output logic
    assign done = (state == 10'b1000000000);   // Set done output when current state is Count
    assign counting = (state[9]);   // Set counting output based on the highest bit of the current state
    assign shift_ena = (state == 10'b1000000100);   // Set shift_ena output when current state is Wait

endmodule
