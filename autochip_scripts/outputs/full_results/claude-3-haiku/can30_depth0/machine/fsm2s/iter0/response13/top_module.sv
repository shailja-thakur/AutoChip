module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state; // 0 for state A, 1 for state B

always @(posedge clk) begin
    if (reset) begin
        state <= 0; // Initialize to state A
    end
    else begin
        case (state)
            0: // State A
                if (j) begin
                    state <= 1; // Transition to state B
                end
                else begin
                    state <= 0; // Remain in state A
                end
            1: // State B
                if (k) begin
                    state <= 0; // Transition to state A
                end
                else begin
                    state <= 1; // Remain in state B
                end
        endcase
    end
end

always @(*) begin
    out = state; // Output is high when in state B, low when in state A
end

endmodule
