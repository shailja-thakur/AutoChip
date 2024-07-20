module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

localparam STATE_OFF = 0, STATE_ON = 1;
reg state;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_OFF;
        out <= 0;
    end
    else begin
        case (state)
            STATE_OFF: begin
                if (j) begin
                    state <= STATE_ON;
                    out <= 1;
                end
                else begin
                    state <= STATE_OFF;
                    out <= 0;
                end
            end
            STATE_ON: begin
                if (k) begin
                    state <= STATE_OFF;
                    out <= 0;
                end
                else begin
                    state <= STATE_ON;
                    out <= 1;
                end
            end
            default: begin
                state <= STATE_OFF;
                out <= 0;
            end
        endcase
    end
end

endmodule
