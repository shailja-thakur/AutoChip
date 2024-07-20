module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state;
parameter OFF = 0, ON = 1;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= OFF;
        out <= 0;
    end
    else begin
        case (state)
            OFF: begin
                if (j) begin
                    state <= ON;
                    out <= 1;
                end
                else begin
                    state <= OFF;
                    out <= 0;
                end
            end
            ON: begin
                if (k) begin
                    state <= OFF;
                    out <= 0;
                end
                else begin
                    state <= ON;
                    out <= 1;
                end
            end
        endcase
    end
end

endmodule
