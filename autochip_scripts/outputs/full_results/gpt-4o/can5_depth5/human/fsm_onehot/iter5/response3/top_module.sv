module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

    always @(*) begin
        // Initialize next_state and outputs
        next_state = 10'b0000000000;
        out1 = 0;
        out2 = 0;

        // Corrected state transition logic
        next_state[0] = (state[0] & ~in) | (state[1] & ~in) | (state[2] & ~in) | (state[3] & ~in) | (state[4] & ~in) | (state[5] & ~in) | (state[6] & ~in) | (state[7] & ~in) | (state[8] & ~in) | (state[9] & ~in);
        next_state[1] = state[0] & in | state[8] & in | state[9] & in;
        next_state[2] = state[1] & in;
        next_state[3] = state[2] & in;
        next_state[4] = state[3] & in;
        next_state[5] = state[4] & in;
        next_state[6] = state[5] & in;
        next_state[7] = (state[6] & in) | (state[7] & in);
        next_state[8] = state[5] & ~in;
        next_state[9] = state[6] & ~in;

        // Output logic
        out1 = state[8] | state[9]; // S8 and S9
        out2 = state[7] | state[9]; // S7 and S9
    end
endmodule
