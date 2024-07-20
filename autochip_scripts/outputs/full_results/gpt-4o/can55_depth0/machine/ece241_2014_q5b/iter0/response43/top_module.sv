module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // Next state logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // State transition
    always @(*) begin
        case (state)
            A: if (x)
                    next_state = B;
                else
                    next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = (x == 1) ? 1 : 0;
            B: z = (x == 0) ? 1 : 0;
            default: z = 0;
        endcase
    end
    
endmodule
