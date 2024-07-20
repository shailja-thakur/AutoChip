module top_module(
    output reg zero,
    input clk);

always @(posedge clk)
    zero <= 1'b0;

endmodule
