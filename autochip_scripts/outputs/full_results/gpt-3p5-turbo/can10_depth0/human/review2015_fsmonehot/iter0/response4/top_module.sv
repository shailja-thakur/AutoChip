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
assign B3_next = (state == 10'b0000000001);  // Transition to B3 state if current state is S
assign S_next = (state == 10'b0000000000);   // Transition to S state if current state is B3
assign S1_next = (state == 10'b0000000010);  // Transition to S1 state if current state is S1
assign Count_next = (state == 10'b1000000000) && (done_counting == 0);  // Transition to Count state if current state is B3 and done_counting is 0
assign Wait_next = (state == 10'b1000000000) && (done_counting == 1);  // Transition to Wait state if current state is B3 and done_counting is 1

// Output logic
assign done = (state == 10'b1000000000) && (ack == 0);  // Output done is 1 if current state is B3 and ack is 0
assign counting = (state == 10'b1000000000) || (state == 10'b1000000001);  // Output counting is 1 if current state is B3 or B1
assign shift_ena = (state >= 10'b1000000000) && (state <= 10'b1000000100);  // Output shift_ena is 1 if current state is B0, B1, B2, or B3

endmodule
