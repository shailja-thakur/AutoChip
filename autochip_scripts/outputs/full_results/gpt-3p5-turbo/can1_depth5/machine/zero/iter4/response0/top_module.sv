module top_module(
    output reg zero,
    input clk);

initial
    $display("Module instantiated");

always @(posedge clk)
    zero <= 1'b0;

endmodule
