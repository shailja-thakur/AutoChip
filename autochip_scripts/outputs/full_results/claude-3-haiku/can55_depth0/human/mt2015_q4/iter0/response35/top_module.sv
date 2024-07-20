module top_module(
    input x,
    input y,
    output z
);

// Submodules
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
assign c = ~((a ^ b) & a);
endmodule
