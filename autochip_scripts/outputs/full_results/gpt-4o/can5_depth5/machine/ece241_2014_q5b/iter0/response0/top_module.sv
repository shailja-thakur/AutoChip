module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
 
    // Define states
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Sequential logic for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: next_state = A; // Default state to handle uninitialized state
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0;
        endcase
    end
    
endmodule
