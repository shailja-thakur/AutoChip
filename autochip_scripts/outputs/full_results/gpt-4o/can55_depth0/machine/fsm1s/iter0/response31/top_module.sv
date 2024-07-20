module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block to determine next state
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A;  // Default case for safety
        endcase
    end

    // Always block triggered on the rising edge of the clock or reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B; // Reset to initial state B
        end else begin
            state <= next_state; // Update state with next state
        end
    end

    // Output logic
    always @(state) begin
        out = (state == B) ? 1'b1 : 1'b0;
    end

endmodule
