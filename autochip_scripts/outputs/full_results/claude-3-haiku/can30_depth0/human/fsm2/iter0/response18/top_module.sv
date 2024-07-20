module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state; // 0 = OFF, 1 = ON

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 0; // Reset to OFF state
        out <= 0;
    end else begin
        case (state)
            0: begin // OFF state
                if (j) begin
                    state <= 1; // Transition to ON state
                    out <= 1;
                end else begin
                    state <= 0; // Stay in OFF state
                    out <= 0;
                end
            end
            1: begin // ON state
                if (k) begin
                    state <= 0; // Transition to OFF state
                    out <= 0;
                end else begin
                    state <= 1; // Stay in ON state
                    out <= 1;
                end
            end
            default: begin
                state <= 0; // Default to OFF state
                out <= 0;
            end
        endcase
    end
end

endmodule
