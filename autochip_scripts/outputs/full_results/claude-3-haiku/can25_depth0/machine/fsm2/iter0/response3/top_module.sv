module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State transition logic
always @(*) begin
    case (state)
        1'b0: // State A
            if (j)
                next_state = 1'b1; // Transition to State B
            else
                next_state = 1'b0; // Remain in State A
        1'b1: // State B
            if (k)
                next_state = 1'b0; // Transition to State A
            else
                next_state = 1'b1; // Remain in State B
        default:
            next_state = 1'b0; // Default to State A
    endcase
end

// State update logic
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 1'b0; // Reset to State A
    else
        state <= next_state;
end

// Output logic
assign out = state;

endmodule
