module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding using one-hot encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State registers
    reg state, next_state;
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
            default: z = 1'b0;
        endcase
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = x ? B : B;
            default: next_state = A;
        endcase
    end
    
    // State register update (with asynchronous reset)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
endmodule
