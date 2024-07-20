module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State definition
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    next_state = A; // Stay in state A
                else
                    next_state = B; // Transition to state B
            end
            B: begin
                if (in)
                    next_state = B; // Stay in state B
                else
                    next_state = A; // Transition to state A
            end
            default: next_state = A; // Default state
        endcase
    end
    
    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset to state B
        else
            state <= next_state; // Update state
    end
    
    // Output logic
    assign out = (state == B); // Output high if state is B, low otherwise

endmodule
