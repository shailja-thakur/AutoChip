module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    localparam A = 1'b0;
    localparam B = 1'b1;

    // Current state and next state
    reg state, next_state;

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = j ? B : A;
            B: next_state = k ? A : B;
            default: next_state = A; // Default state
        endcase
    end

    // Sequential logic for state update
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset to state A
        else
            state <= next_state; // Update to next state
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
