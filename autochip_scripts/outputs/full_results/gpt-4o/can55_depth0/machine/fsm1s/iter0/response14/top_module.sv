module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    // State Definitions
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State Register
    reg state, next_state;

    // Combinational Logic for Next State
    always @(*) begin
        case (state)
            A: begin
                if (in)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end
            default: next_state = A; // Default to A for safety
        endcase
    end

    // Sequential Logic for State Transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Reset state to B
        else
            state <= next_state;
    end

    // Output Logic
    always @(*) begin
        if (state == B)
            out = 1'b1; // Output high when in state B
        else
            out = 1'b0; // Output low otherwise
    end
endmodule
