module top_module (
    input clk,
    input in,
    input reset,
    output out
);

parameter STATE_A = 1'b0;
parameter STATE_B = 1'b1;

reg state;

always @(posedge clk) begin
    if (reset)
        state <= STATE_B;
    else
        case (state)
            STATE_A: state <= (in) ? STATE_A : STATE_B;
            STATE_B: state <= (in) ? STATE_B : STATE_A;
        endcase
end

assign out = (state == STATE_B);

endmodule
