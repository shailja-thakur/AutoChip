module top_module(
    input x,
    input y,
    output z
);

wire z_a1, z_a2, z_b1, z_b2;

// Module A implements the boolean function z = (x^y) & x.
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
    assign c = ((a & ~b) | (~a & b)) | (~a & ~b);
endmodule
