module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Define state parameters
parameter OFF = 1'b0, ON = 1'b1;

// Define state register
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset to OFF state
        state <= OFF;
        out <= 1'b0;
    end
    else begin
        case (state)
            OFF: begin
                if (j) begin
                    // Transition from OFF to ON
                    state <= ON;
                    out <= 1'b1;
                end
                else begin
                    // Stay in OFF state
                    state <= OFF;
                    out <= 1'b0;
                end
            end
            ON: begin
                if (k) begin
                    // Transition from ON to OFF
                    state <= OFF;
                    out <= 1'b0;
                end
                else begin
                    // Stay in ON state
                    state <= ON;
                    out <= 1'b1;
                end
            end
            default: begin
                // Invalid state, reset to OFF
                state <= OFF;
                out <= 1'b0;
            end
        endcase
    end
end

endmodule
