module top_module(
    input x,
    input y,
    output z
);

wire z1, z2;

// Module A
module A (
    input a,
    input b,
    output c
);
assign c = (a ^ b) & a;
endmodule
module B (
    input a,
    input b,
    output c
);
assign c = ((a ^ b) & a) | ((a & ~b) | (~a & b));
endmodule
