module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state;
parameter OFF = 0, ON = 1;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
        out <= 0;
    end
    else begin
        case (state)
            OFF: begin
                out <= 0;
                if (j) begin
                    state <= ON;
                end
                else begin
                    state <= OFF;
                end
            end
            ON: begin
                out <= 1;
                if (k) begin
                    state <= OFF;
                end
                else begin
                    state <= ON;
                end
            end
        endcase
    end
end

endmodule
