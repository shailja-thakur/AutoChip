module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define the states as parameters
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Synchronous state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;  // On reset, go to state A
        end else begin
            state <= next_state;  // Otherwise, transition to next state
        end
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
            default: next_state = A;
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
