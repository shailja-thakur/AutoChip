module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

localparam OFF = 1'b0, ON = 1'b1;
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
        out <= 1'b0;
    end
    else begin
        case (state)
            OFF: begin
                out <= 1'b0;
                if (j) begin
                    state <= ON;
                end
                else begin
                    state <= OFF;
                end
            end
            ON: begin
                out <= 1'b1;
                if (k) begin
                    state <= OFF;
                end
                else begin
                    state <= ON;
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
