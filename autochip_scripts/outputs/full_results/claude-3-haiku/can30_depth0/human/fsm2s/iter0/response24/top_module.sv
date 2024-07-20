module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state; // 0 for OFF, 1 for ON

always @(posedge clk) begin
    if (reset) begin
        state <= 0; // Reset to OFF state
        out <= 0;
    end
    else begin
        case (state)
            0: // OFF state
                if (j) begin
                    state <= 1; // Transition to ON state
                    out <= 1;
                end
                else begin
                    state <= 0; // Remain in OFF state
                    out <= 0;
                end
            1: // ON state
                if (k) begin
                    state <= 0; // Transition to OFF state
                    out <= 0;
                end
                else begin
                    state <= 1; // Remain in ON state
                    out <= 1;
                end
            default:
                begin
                    state <= 0; // Default to OFF state
                    out <= 0;
                end
        endcase
    end
end

endmodule
