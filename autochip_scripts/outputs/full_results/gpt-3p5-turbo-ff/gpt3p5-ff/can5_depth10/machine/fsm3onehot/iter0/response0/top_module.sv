module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);
    
    // Assign statements for next_state[A], next_state[B], next_state[C], next_state[D]
    always @*
    begin
        if (in == 0)
        begin
            next_state[0] = state[0] | state[2];
            next_state[1] = 0;
            next_state[2] = state[1] | state[3];
            next_state[3] = 0;
        end
        else
        begin
            next_state[0] = 0;
            next_state[1] = state[0] | state[1] | state[3];
            next_state[2] = 0;
            next_state[3] = state[2];
        end
    end
    
    // Assign statement for out
    always @*
    begin
        out = state[3];
    end
    
endmodule
