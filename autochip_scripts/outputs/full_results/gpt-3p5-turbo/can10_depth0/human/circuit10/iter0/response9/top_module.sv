module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg q;
reg state;
reg next_q;
reg next_state;

always @(posedge clk) begin
    next_q = a & ~b;
    next_state = (state & ~a) | (a & b);
end

always @(posedge clk) begin
    q <= next_q;
    state <= next_state;
end

assign q = next_q;
assign state = next_state;

endmodule
