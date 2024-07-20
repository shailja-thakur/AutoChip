module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // Assign statements
    always @*
    begin
        // First assign statement
        if (in == 0)
            next_state[0] = state[0] | state[2];
        else
            next_state[0] = 0;
        
        // Second assign statement
        if (in == 0)
            next_state[1] = 0;
        else
            next_state[1] = state[0] | state[1] | state[3];
        
        // Third assign statement
        if (in == 0)
            next_state[2] = state[1] | state[3];
        else
            next_state[2] = 0;
        
        // Fourth assign statement
        if (in == 0)
            next_state[3] = 0;
        else
            next_state[3] = state[2];
    end
    
    // Assign out
    assign out = state[3];

endmodule
