module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding using parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // Internal state register
    reg [1:0] state, next_state;
    
    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = (x) ? C : A;
            B: next_state = (x) ? B : C;
            C: next_state = (x) ? B : C;
            default: next_state = A;
        endcase
    end
    
    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        z = (state == C);
    end
    
endmodule
