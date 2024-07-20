module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    // State encoding
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;
    
    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            A: if (x) next_state = C; else next_state = A;
            B: if (x) next_state = B; else next_state = C;
            C: if (x) next_state = B; else next_state = C;
            default: next_state = A; // Default state
        endcase
    end
    
    // Output logic
    assign z = (state == C);

endmodule
