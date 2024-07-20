module top_module(
    input x,
    input y,
    output z
);

// Submodule A
module A(
    input x,
    input y,
    output z
);
assign z = (x ^ y) & x;
endmodule
module B(
    input x,
    input y,
    output z
);
assign z = (x == 0 && y == 0) || (x == 1 && y == 1);
endmodule
