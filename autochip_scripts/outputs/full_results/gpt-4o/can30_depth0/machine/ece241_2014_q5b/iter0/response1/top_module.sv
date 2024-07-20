module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define states
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State register
    reg state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
            default: next_state = A;
        endcase
    end
    
    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
