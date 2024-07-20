module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define the two states A and B
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Asynchronous reset logic and state transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A;
        else 
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: if (x) 
                    next_state = B; 
               else 
                    next_state = A;
            B: next_state = B;
            default: next_state = A;  // default case to handle undefined states
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: if (x) 
                    z = 1'b1; 
               else 
                    z = 1'b0;
            B: if (~x) 
                    z = 1'b1; 
               else 
                    z = 1'b0;
        endcase
    end

endmodule
