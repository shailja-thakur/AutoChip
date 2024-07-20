module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
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
    
    always @(*) begin
        case (state)
            A: z = x;
            B: z = !x;
            default: z = 0;
        endcase
    end

endmodule
