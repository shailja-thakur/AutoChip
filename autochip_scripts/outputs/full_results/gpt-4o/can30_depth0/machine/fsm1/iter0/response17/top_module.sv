module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // Define states using parameters
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State registers
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = (in) ? A : B;
            B: next_state = (in) ? B : A;
            default: next_state = B;  // Default to state B for safety
        endcase
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= B;  // Reset state to B
        end else begin
            state <= next_state;  // Update state to next_state
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            A: out = 1'b0;
            B: out = 1'b1;
            default: out = 1'b0;  // Default to 0 for safety
        endcase
    end

endmodule
