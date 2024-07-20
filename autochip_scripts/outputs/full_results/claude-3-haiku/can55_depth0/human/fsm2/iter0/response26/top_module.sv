module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

parameter STATE_OFF = 1'b0;
parameter STATE_ON  = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_OFF;
        out <= 1'b0;
    end
    else begin
        case (state)
            STATE_OFF: begin
                out <= 1'b0;
                if (j) begin
                    state <= STATE_ON;
                end
                else begin
                    state <= STATE_OFF;
                end
            end
            STATE_ON: begin
                out <= 1'b1;
                if (k) begin
                    state <= STATE_OFF;
                end
                else begin
                    state <= STATE_ON;
                end
            end
        endcase
    end
end

endmodule
