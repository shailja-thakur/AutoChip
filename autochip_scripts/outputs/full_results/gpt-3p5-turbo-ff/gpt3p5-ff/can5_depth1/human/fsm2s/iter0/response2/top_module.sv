module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
parameter OFF = 0;
parameter ON = 1;

always @(posedge clk) begin
    if (reset) begin
        state <= OFF;
    end else begin
        case (state)
            OFF: begin
                if (j) begin
                    out <= 1;
                    state <= ON;
                end else begin
                    out <= 0;
                    state <= OFF;
                end
            end
            ON: begin
                if (~k) begin
                    out <= 0;
                    state <= ON;
                end else begin
                    out <= 1;
                    state <= OFF;
                end
            end
        endcase
    end
end

endmodule
