module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state, next_state;

    // Combinational always block: Determine next state
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // Default case for safety
        endcase
    end

    // Clocked always block: Update state based on areset and next_state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset to state A
        else
            state <= next_state; // Update to next state
    end

    // Output logic: out is high if current state is B, otherwise low
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 0; // Reset output when areset is high
        else
            out <= (state == B);
    end

endmodule
