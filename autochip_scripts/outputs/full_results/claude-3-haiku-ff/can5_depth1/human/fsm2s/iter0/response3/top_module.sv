module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

localparam STATE_OFF = 1'b0;
localparam STATE_ON = 1'b1;

reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_OFF;
        out <= 1'b0;
    end
    else begin
        case (state)
            STATE_OFF: begin
                if (j) begin
                    state <= STATE_ON;
                    out <= 1'b1;
                end
                else begin
                    state <= STATE_OFF;
                    out <= 1'b0;
                end
            end
            STATE_ON: begin
                if (k) begin
                    state <= STATE_OFF;
                    out <= 1'b0;
                end
                else begin
                    state <= STATE_ON;
                    out <= 1'b1;
                end
            end
            default: begin
                state <= STATE_OFF;
                out <= 1'b0;
            end
        endcase
    end
end

endmodule
