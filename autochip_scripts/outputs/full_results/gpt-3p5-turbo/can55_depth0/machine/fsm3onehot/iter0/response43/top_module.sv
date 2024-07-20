module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

    always @* begin
        // Assign values to next_state[A]
        if (in == 0) begin
            next_state[0] = state[0] | state[2];
        end else begin
            next_state[0] = 0;
        end
        
        // Assign values to next_state[B]
        if (in == 0) begin
            next_state[1] = 0;
        end else begin
            next_state[1] = state[0] | state[1] | state[3];
        end
        
        // Assign values to next_state[C]
        if (in == 0) begin
            next_state[2] = state[1] | state[3];
        end else begin
            next_state[2] = 0;
        end
        
        // Assign values to next_state[D]
        if (in == 0) begin
            next_state[3] = 0;
        end else begin
            next_state[3] = state[2];
        end
    end
    
    assign out = state[3];
    
endmodule
