module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // assign statements
    always @(state or in) begin
        // first assign statement
        if (in == 1'b0)
            next_state[0] = state[0] | state[2];
        else
            next_state[0] = 1'b0;
        
        // second assign statement
        if (in == 1'b0)
            next_state[1] = 1'b0;
        else
            next_state[1] = state[0] | state[1] | state[3];
        
        // third assign statement
        if (in == 1'b0)
            next_state[2] = state[1] | state[3];
        else
            next_state[2] = 1'b0;
        
        // fourth assign statement
        if (in == 1'b0)
            next_state[3] = 1'b0;
        else
            next_state[3] = state[2];
        
        // assign value to out
        out = state[3];
        
    end

endmodule
