module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define the states
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // If areset is high, set state to A
        else
            state <= next_state; // Otherwise, update the state to the next state
    end
    
    // Next-state logic
    always @(*) begin
        case(state)
            A: begin
                if (x)
                    next_state = B; // If state is A and x is 1, transition to state B
                else
                    next_state = A; // Otherwise, remain in state A
            end
            B: begin
                next_state = B; // Remain in state B
            end
            default: next_state = A; // Default case to avoid latches
        endcase
    end
    
    // Output logic
    always @(*) begin
        case(state)
            A: z = x ? 1'b1 : 1'b0; // If state is A and x is 1, z = 1, otherwise z = 0
            B: z = x ? 1'b0 : 1'b1; // If state is B and x is 0, z = 1, otherwise z = 0
            default: z = 1'b0; // Default case to avoid latches
        endcase
    end
    
endmodule
