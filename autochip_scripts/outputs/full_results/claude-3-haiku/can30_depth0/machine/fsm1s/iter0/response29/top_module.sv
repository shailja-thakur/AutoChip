module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter STATE_A = 1'b0;
parameter STATE_B = 1'b1;

reg state;

always @(posedge clk) begin
    if (reset)
        state <= STATE_B;
    else
        case (state)
            STATE_A:
                state <= (in == 1'b1) ? STATE_A : STATE_B;
            STATE_B:
                state <= (in == 1'b1) ? STATE_B : STATE_A;
            default:
                state <= STATE_B;
        endcase
end

always @(*) begin
    out = (state == STATE_B) ? 1'b1 : 1'b0;
end

endmodule
