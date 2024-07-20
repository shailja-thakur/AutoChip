module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Declare state registers
reg state, next_state;

always @(*) begin
    // Combinational logic for next state
    case (state)
        1'b0: // State A
            if (j) next_state = 1'b1; // State B
            else next_state = 1'b0; // State A
        1'b1: // State B
            if (k) next_state = 1'b0; // State A
            else next_state = 1'b1; // State B
        default: next_state = 1'b0; // Default to State A
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to State A
    end
    else begin
        state <= next_state; // Update state
    end
end

// Output logic
assign out = state; // Output current state

endmodule
