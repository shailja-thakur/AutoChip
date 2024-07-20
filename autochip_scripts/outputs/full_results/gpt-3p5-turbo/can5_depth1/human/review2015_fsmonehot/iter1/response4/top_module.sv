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

    // State transition logic
    always @(*)
    begin
        B3_next = (state == 10'b0111111111);   // Transition to B3 if current state is B2
        S_next = (state == 10'b0000000001);    // Transition to S if current state is B3
        S1_next = (state == 10'b0000000010);   // Transition to S1 if current state is S
        Count_next = (state == 10'b1000000000) ? !done_counting : state[9];   // Transition to Count if current state is B3 and done_counting is not set, otherwise stay in Count
        Wait_next = (state == 10'b1000000100) ? ack : state[9];   // Transition to Wait if current state is B3 and ack is set, otherwise stay in Wait
    end

    // Output logic
    always @(*)
    begin
        done = (state == 10'b1000000000);   // Set done output when current state is Count
        counting = (state[9]);   // Set counting output based on the highest bit of the current state
        shift_ena = (state == 10'b1000000100);   // Set shift_ena output when current state is Wait
    end

endmodule
