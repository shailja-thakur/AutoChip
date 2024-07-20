module top_module(
    input clk,
    input d,
    output reg q);

  initial
    q = 1'bX;

  always @(posedge clk)
    q <= d;

endmodule
