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
        // State transition logic
        B3_next = (state == 10'b0111111111);   // Transition to B3 if current state is B2
        S_next = (state == 10'b0000000001);    // Transition to S if current state is B3
        S1_next = (state == 10'b0000000010);   // Transition to S1 if current state is S
        if(state == 10'b1000000000)  // Transition to B3 if current state is Count
            Count_next = !done_counting;
        else
            Count_next = state[9];
        if(state == 10'b1000000100)  // Transition to Wait if current state is B3
            Wait_next = ack;
        else
            Wait_next = state[9];
    end

    always @(posedge clk) begin
        // Output logic
        done = (state == 10'b1000000000);   // Set done output when current state is Count
        counting = state[9];   // Set counting output based on the highest bit of the current state
        shift_ena = (state == 10'b1000000100);   // Set shift_ena output when current state is Wait
    end

endmodule
