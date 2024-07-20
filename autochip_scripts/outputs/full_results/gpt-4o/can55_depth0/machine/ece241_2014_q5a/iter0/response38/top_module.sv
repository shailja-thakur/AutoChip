module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;
    
    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state to A
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = x ? C : A;
            B: next_state = x ? B : C;
            C: next_state = x ? B : C;
            default: next_state = A;
        endcase
    end
    
    // Output logic
    always @(*) begin
        z = (state == C);
    end

endmodule
