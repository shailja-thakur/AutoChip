module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk)
    if (a)
        q <= q + 1'b1;
    else
        q <= q;

endmodule
