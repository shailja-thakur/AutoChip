module top_module(
    input x,
    input y,
    output z
);

// Module A implements the boolean function z = (x^y) & x.
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
assign c = ~((a ^ b) | a);
endmodule
