module top_module (
    input clk,
    input in,
    output reg out
);

initial
    out = 0;

always @(posedge clk)
    out <= ^out & in;

endmodule
