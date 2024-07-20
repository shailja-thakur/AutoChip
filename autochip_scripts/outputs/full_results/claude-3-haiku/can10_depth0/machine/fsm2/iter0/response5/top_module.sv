module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        1'b0: // State A
            if (j) begin
                next_state = 1'b1; // Transition to State B
            end else begin
                next_state = 1'b0; // Remain in State A
            end
        1'b1: // State B
            if (k) begin
                next_state = 1'b0; // Transition to State A
            end else begin
                next_state = 1'b1; // Remain in State B
            end
        default:
            next_state = 1'b0; // Default to State A
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to State A
    end else begin
        state <= next_state;
    end
end

// Output logic
assign out = state; // Output the current state

endmodule
