module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// Combinational logic to determine next state
always @(*) begin
    case (state)
        1'b0: // State A
            if (j)
                next_state = 1'b1; // Transition to state B
            else
                next_state = 1'b0; // Stay in state A
        1'b1: // State B
            if (k)
                next_state = 1'b0; // Transition to state A
            else
                next_state = 1'b1; // Stay in state B
    endcase
end

// Sequential logic to update state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 1'b0; // Reset to state A
    else
        state <= next_state;
end

// Assign output based on current state
always @(*) begin
    out = state; // Output high when in state B, low when in state A
end

endmodule
