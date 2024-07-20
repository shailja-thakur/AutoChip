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
                out <= 1'b0;
                if (j)
                    state <= STATE_ON;
                else
                    state <= STATE_OFF;
            end
            STATE_ON: begin
                out <= 1'b1;
                if (k)
                    state <= STATE_OFF;
                else
                    state <= STATE_ON;
            end
            default: begin
                state <= STATE_OFF;
                out <= 1'b0;
            end
        endcase
    end
end

endmodule
