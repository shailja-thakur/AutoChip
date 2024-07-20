module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

localparam STATE_OFF = 1'b0;
localparam STATE_ON = 1'b1;

reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_OFF;
        out <= 1'b0;
    end
    else begin
        case (state)
            STATE_OFF: begin
                if (j)
                    state <= STATE_ON;
                else
                    state <= STATE_OFF;
                out <= 1'b0;
            end
            STATE_ON: begin
                if (k)
                    state <= STATE_OFF;
                else
                    state <= STATE_ON;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
