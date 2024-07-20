module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // First assign statement for next_state[A]
    always @(*) begin
        if (in == 1'b0) 
            next_state[0] = state[0] | state[2];  // state[A] or state[C]
        else
            next_state[0] = 1'b0;
        
        // Second assign statement for next_state[B]
        if (in == 1'b0)
            next_state[1] = 1'b0;
        else
            next_state[1] = state[0] | state[1] | state[3];  // state[A] or state[B] or state[D]

        // Third assign statement for next_state[C]
        if (in == 1'b0)
            next_state[2] = state[1] | state[3];  // state[B] or state[D]
        else
            next_state[2] = 1'b0;

        // Fourth assign statement for next_state[D]
        if (in == 1'b1)
            next_state[3] = state[2];  // state[C]
        else
            next_state[3] = 1'b0;
    end

    // Assign out port
    assign out = state[3];  // state[D]

endmodule
