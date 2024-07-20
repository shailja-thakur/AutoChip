module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B;
    end
    else begin
        case (state)
            STATE_B: begin
                out <= 1'b1;
                if (in) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_A;
                end
            end
            STATE_A: begin
                out <= 1'b0;
                if (in) begin
                    state <= STATE_A;
                end
                else begin
                    state <= STATE_B;
                end
            end
        endcase
    end
end

endmodule
