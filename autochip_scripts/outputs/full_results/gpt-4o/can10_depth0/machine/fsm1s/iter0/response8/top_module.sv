module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = A;  // Default state
        endcase
    end
    
    // Sequential logic to update the current state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Initial state on reset
        else
            state <= next_state;
    end
    
    // Output logic
    assign out = (state == B);

endmodule
