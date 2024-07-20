module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = B;  // Default state when reset
        endcase
    end
    
    // Sequential block to update the state register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Initial state on reset
        else
            state <= next_state;
    end
    
    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b1;  // Output high when in state B (initial state)
        else
            out <= (state == B);  // Output is high when in state B
    end

endmodule
