module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_b1, z_a2, z_b2;

// Module A implementation
module A (
    input x,
    input y,
    output z
);
assign z = (x ^ y) & x;
endmodule
module B (
    input x,
    input y,
    output z
);
assign z = (x == 0 && y == 0) || (x == 1 && y == 1);
endmodule
