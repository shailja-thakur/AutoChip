module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state; // State variable to store the current state
reg next_state; // Variable to store the next state

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        1'b0: // State A
            if (j)
                next_state = 1'b1; // Transition to state B
            else
                next_state = 1'b0; // Remain in state A
        1'b1: // State B
            if (k)
                next_state = 1'b0; // Transition to state A
            else
                next_state = 1'b1; // Remain in state B
        default:
            next_state = 1'b0; // Default to state A
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 1'b0; // Reset to state A
    else
        state <= next_state; // Update the state
end

// Combinational logic to set the output
always @(*) begin
    out = state; // Set the output to the current state
end

endmodule
