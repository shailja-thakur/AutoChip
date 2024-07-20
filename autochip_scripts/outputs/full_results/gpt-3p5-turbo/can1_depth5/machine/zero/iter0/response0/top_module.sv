module top_module(
    output reg zero);

always @(posedge clk)
    zero <= 1'b0;

endmodule
