module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
    // Define state parameters
    parameter A = 1'b0;
    parameter B = 1'b1;
    
    // State register
    reg state, next_state;

    // Output logic
    always @(state) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
        endcase
    end

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;         // Reset state to A
        else
            state <= next_state; // Transition to next state
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = j ? B : A; // If j is high go to B, else stay in A
            B: next_state = k ? A : B; // If k is high go to A, else stay in B
            default: next_state = A;   // Default to state A
        endcase
    end
    
endmodule
