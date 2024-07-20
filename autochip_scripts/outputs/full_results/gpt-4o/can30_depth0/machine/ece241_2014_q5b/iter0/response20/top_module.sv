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
    
    // State Machine (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;  // Asynchronous reset to state A
        else 
            state <= next_state;  // Transition to the next state
    end
    
    // Next State Logic (combinational)
    always @(*) begin
        case(state)
            A: begin
                if(x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;  // Remain in state B
            end
        endcase
    end
    
    // Output Logic (combinational)
    always @(*) begin
        case(state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
        endcase
    end

endmodule
