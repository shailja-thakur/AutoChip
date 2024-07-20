module top_module (
    input clk,
    input x,
    output z
);

reg [2:0] flip_flops;
wire [2:0] flip_flops_complement;

assign flip_flops_complement = ~flip_flops;

DFF dff0 (
    .clk(clk),
    .d(x ^ flip_flops[0]),
    .q(flip_flops[0])
);

DFF dff1 (
    .clk(clk),
    .d(~(x & flip_flops[1])),
    .q(flip_flops[1])
);

DFF dff2 (
    .clk(clk),
    .d(~(x | flip_flops[2])),
    .q(flip_flops[2])
);

XNOR xnor (
    .a(flip_flops[0]),
    .b(flip_flops_complement[1]),
    .c(flip_flops_complement[2]),
    .z(z)
);

endmodule
