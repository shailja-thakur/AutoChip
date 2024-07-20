module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // State encoding
    parameter A = 1'b0, B = 1'b1; // State A is encoded as 0, State B as 1

    reg state, next_state;

    // Combinational logic block to determine the next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B; // If in is high, stay in A; if low, go to B
            B: next_state = in ? B : A; // If in is high, stay in B; if low, go to A
            default: next_state = A; // Default state
        endcase
    end

    // Always block triggered on the rising edge of clk or when reset is high
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset to state B
        end
        else begin
            state <= next_state; // Update state to next state
        end
    end

    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0; // Output is high if in state B, low otherwise

endmodule
