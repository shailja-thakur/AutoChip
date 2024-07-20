module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    // Parameters for the states
    parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;  // Reset state
        else
            state <= next_state;  // State transition
    end
    
    // Combinatorial logic for next state
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
        if (state == C)
            z = 1'b1;
        else
            z = 1'b0;
    end
    
endmodule
