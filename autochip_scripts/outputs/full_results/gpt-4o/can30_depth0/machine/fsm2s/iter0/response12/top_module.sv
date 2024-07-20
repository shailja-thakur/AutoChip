module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A; // On reset, go to state A
        else
            state <= next_state; // Otherwise, transition to next state
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B; // Transition to state B when j is high
                else
                    next_state = A; // Remain in state A when j is low
            end
            B: begin
                if (k)
                    next_state = A; // Transition to state A when k is high
                else
                    next_state = B; // Remain in state B when k is low
            end
            default: next_state = A; // Default to state A
        endcase
    end

    // Output logic
    always @(state) begin
        case (state)
            A: out = 1'b0; // Output is low when in state A
            B: out = 1'b1; // Output is high when in state B
            default: out = 1'b0; // Default output is low
        endcase
    end

endmodule
