module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

localparam OFF = 0, ON = 1;
reg state;

always @(posedge clk) begin
    if (reset) begin
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
