module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    // First assign statement
    assign next_state[0] = in ? 4'b0000 : state[0] | state[2];
    
    // Second assign statement
    assign next_state[1] = in ? state[0] | state[1] | state[3] : 4'b0000;
    
    // Third assign statement
    assign next_state[2] = in ? state[1] | state[3] : 4'b0000;
    
    // Fourth assign statement
    assign next_state[3] = in ? state[2] : 4'b0000;
    
    // Output assignment
    assign out = state[3];
    
endmodule
