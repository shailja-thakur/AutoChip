module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Parameter for state encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A;
        endcase
    end
    
    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end
    
    // Output logic
    always @(state) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
endmodule
