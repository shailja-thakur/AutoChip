module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg state; // 0 for state A, 1 for state B

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 1'b1; // Reset to state B
    end
    else begin
        case (state)
            1'b0: // State A
                if (in) begin
                    state <= 1'b0; // Stay in state A
                end
                else begin
                    state <= 1'b1; // Transition to state B
                end
            1'b1: // State B
                if (in) begin
                    state <= 1'b1; // Stay in state B
                end
                else begin
                    state <= 1'b0; // Transition to state A
                end
        endcase
    end
end

always @(*) begin
    if (state == 1'b1) begin
        out = 1'b1; // Output is high when in state B
    end
    else begin
        out = 1'b0; // Output is low when in state A
    end
end

endmodule
