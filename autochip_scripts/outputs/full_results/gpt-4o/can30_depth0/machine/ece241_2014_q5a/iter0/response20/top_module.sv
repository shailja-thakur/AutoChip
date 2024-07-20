module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            A: if (x) begin
                    next_state = C;
               end else begin
                    next_state = A;
               end
            B: if (x) begin
                    next_state = B;
               end else begin
                    next_state = C;
               end
            C: if (x) begin
                    next_state = B;
               end else begin
                    next_state = C;
               end
            default: next_state = A;
        endcase
    end
    
    always @(*) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
    
endmodule
