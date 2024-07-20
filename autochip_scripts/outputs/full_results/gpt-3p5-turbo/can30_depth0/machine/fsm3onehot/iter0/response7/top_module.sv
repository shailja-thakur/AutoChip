module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    always @*
    begin
        // First assign statement
        if (in == 1'b0)
            next_state[0] = state[0] | state[2];
        else
            next_state[0] = 1'b0;

        // Second assign statement
        if (in == 1'b0)
            next_state[1] = 1'b0;
        else
            next_state[1] = state[0] | state[1] | state[3];

        // Third assign statement
        if (in == 1'b0)
            next_state[2] = state[1] | state[3];
        else
            next_state[2] = 1'b0;

        // Fourth assign statement
        if (in == 1'b0)
            next_state[3] = 1'b0;
        else
            next_state[3] = state[2];

        // Output assign statement
        out = state[3];
    end

endmodule
