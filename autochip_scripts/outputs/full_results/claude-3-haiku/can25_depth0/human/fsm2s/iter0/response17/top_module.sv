module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

// State variables
reg state;
localparam OFF = 1'b0, ON = 1'b1;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
        out <= 1'b0; // Output is 0 in the OFF state
    end
    else begin
        case (state)
            OFF: begin
                if (j) begin
                    state <= ON;
                    out <= 1'b1; // Output is 1 in the ON state
                end
                else begin
                    state <= OFF;
                    out <= 1'b0; // Output is 0 in the OFF state
                end
            end
            ON: begin
                if (k) begin
                    state <= OFF;
                    out <= 1'b0; // Output is 0 in the OFF state
                end
                else begin
                    state <= ON;
                    out <= 1'b1; // Output is 1 in the ON state
                end
            end
            default: begin
                state <= OFF;
                out <= 1'b0; // Output is 0 in the OFF state
            end
        endcase
    end
end

endmodule
