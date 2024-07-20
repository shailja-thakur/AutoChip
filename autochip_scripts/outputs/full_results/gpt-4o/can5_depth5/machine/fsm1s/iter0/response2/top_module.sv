module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State declaration
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block for next state
    always @(*) begin
        case (state)
            A: if (in) next_state = A;
               else next_state = B;
            B: if (in) next_state = B;
               else next_state = A;
            default: next_state = B;  // Default to state B
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Reset to state B
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
