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
    if (reset)
        state <= OFF;
    else begin
        case (state)
            OFF: begin
                out <= 0;
                if (j)
                    state <= ON;
                else
                    state <= OFF;
            end
            ON: begin
                out <= 1;
                if (k)
                    state <= OFF;
                else
                    state <= ON;
            end
        endcase
    end
end

endmodule
