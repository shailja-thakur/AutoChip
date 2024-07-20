module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
reg next_state;

always @(*) begin
    case (state)
        1'b0: // State A
            if (j) begin
                next_state = 1'b1; // State B
            end else begin
                next_state = 1'b0; // State A
            end
        1'b1: // State B
            if (k) begin
                next_state = 1'b0; // State A
            end else begin
                next_state = 1'b1; // State B
            end
        default:
            next_state = 1'b0; // Default to State A
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b0; // Reset to State A
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    out = state; // Output the current state
end

endmodule
