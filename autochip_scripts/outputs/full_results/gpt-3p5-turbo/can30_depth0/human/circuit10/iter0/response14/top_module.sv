module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg flip_flop;

always @(posedge clk) begin
    flip_flop <= (a & b) | (state & ~b);
    state <= flip_flop;
    q <= flip_flop;
end

endmodule
