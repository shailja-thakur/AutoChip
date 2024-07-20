module top_module(
    input x,
    input y,
    output z
);

wire z1, z2;

// Module A
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
assign z = ((x == 0) & (y == 0)) | ((x == 1) & (y == 0)) | ((x == 0) & (y == 1));
endmodule
