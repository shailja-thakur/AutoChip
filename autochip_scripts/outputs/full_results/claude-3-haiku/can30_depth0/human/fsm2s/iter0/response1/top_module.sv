module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state;
parameter OFF = 1'b0, ON = 1'b1;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
        out <= 1'b0;
    end
    else begin
        case (state)
            OFF: begin
                if (j == 1'b0) begin
                    state <= OFF;
                    out <= 1'b0;
                end
                else if (j == 1'b1) begin
                    state <= ON;
                    out <= 1'b1;
                end
            end
            ON: begin
                if (k == 1'b0) begin
                    state <= ON;
                    out <= 1'b1;
                end
                else if (k == 1'b1) begin
                    state <= OFF;
                    out <= 1'b0;
                end
            end
            default: begin
                state <= OFF;
                out <= 1'b0;
            end
        endcase
    end
end

endmodule
