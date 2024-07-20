module top_module(
    input x,
    input y,
    output z
);

// Module A
module A(
    input a,
    input b,
    output c
);
assign c = (a ^ b) & a;
endmodule
module B(
    input a,
    input b,
    output c
);
assign c = (a & ~b) | (~a & b) | (a & b);
endmodule
