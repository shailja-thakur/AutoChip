module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg next_state;

always @(posedge clk) begin
    if (~a & b)
        next_state <= 1'b1;
    else
        next_state <= 1'b0;
end

always @(posedge clk) begin
    state <= next_state;
    q <= state;
end

endmodule
