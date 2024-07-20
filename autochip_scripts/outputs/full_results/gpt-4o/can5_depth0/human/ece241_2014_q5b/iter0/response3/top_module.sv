module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding
    reg state, next_state;
    localparam A = 1'b0, B = 1'b1;
    
    // State transition
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: if (x) next_state = B;
               else next_state = B;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0;
        endcase
    end
    
    // State update
    always @(posedge clk or posedge areset) begin
        if (areset) state <= A;
        else state <= next_state;
    end
endmodule
