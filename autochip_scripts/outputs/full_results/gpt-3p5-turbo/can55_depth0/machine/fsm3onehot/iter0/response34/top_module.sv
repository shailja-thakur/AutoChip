module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    always @(state or in) begin
        // Assign values to next_state[A]
        if (in == 1'b0)
            next_state[0] <= state[0] | state[2];
        else
            next_state[0] <= 4'b0;
        
        // Assign values to next_state[B]
        if (in == 1'b0)
            next_state[1] <= 4'b0;
        else
            next_state[1] <= state[0] | state[1] | state[3];
        
        // Assign values to next_state[C]
        if (in == 1'b0)
            next_state[2] <= state[1] | state[3];
        else
            next_state[2] <= 4'b0;
        
        // Assign values to next_state[D]
        if (in == 1'b0)
            next_state[3] <= 4'b0;
        else
            next_state[3] <= state[2];
    end

    assign out = state[3];

endmodule
