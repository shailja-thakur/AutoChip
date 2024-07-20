module top_module (
    input clk,
    input in,
    output reg out
);

always @(posedge clk)
    out <= ~out;

endmodule
