module top_module (
    input in,
    input [9:0] state,
    output reg [9:0] next_state,
    output out1,
    output out2);

    // Assign out1 as state[8] OR state[9]
    assign out1 = state[8] | state[9];

    // Assign out2 as state[7] OR state[9]
    assign out2 = state[7] | state[9];

    always @(*) begin
        // Calculate next_state[0]
        next_state[0] = ~in & (|state[4:0] | state[7] | state[8] | state[9]);

        // Calculate next_state[1]
        next_state[1] = in & (state[0] | state[8] | state[9]);

        // Calculate next_state[2]
        next_state[2] = in & state[1];

        // Calculate next_state[3]
        next_state[3] = in & state[2];

        // Calculate next_state[4]
        next_state[4] = in & state[3];

        // Calculate next_state[5]
        next_state[5] = in & state[4];

        // Calculate next_state[6]
        next_state[6] = in & state[5];

        // Calculate next_state[7]
        next_state[7] = in & (state[6] | state[7]);

        // Calculate next_state[8]
        next_state[8] = ~in & state[5];

        // Calculate next_state[9]
        next_state[9] = ~in & state[6];
    end

endmodule
