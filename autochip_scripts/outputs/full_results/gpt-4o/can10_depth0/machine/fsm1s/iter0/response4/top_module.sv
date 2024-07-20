module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // Define parameters for the states
    parameter A = 0, B = 1;
    
    // State register
    reg state, next_state;
    
    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;  // default state
        endcase
    end
    
    // Sequential logic to update state register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Reset to initial state B
        else
            state <= next_state;
    end
    
    // Output logic
    assign out = (state == B);

endmodule
