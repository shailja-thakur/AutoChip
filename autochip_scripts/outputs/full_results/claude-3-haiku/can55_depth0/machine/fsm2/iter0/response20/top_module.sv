module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

always @(*) begin
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
    if (areset) state <= 1'b0; // Reset to State A
    else state <= next_state;
end

always @(*) begin
    out = state; // Output current state
end

endmodule
