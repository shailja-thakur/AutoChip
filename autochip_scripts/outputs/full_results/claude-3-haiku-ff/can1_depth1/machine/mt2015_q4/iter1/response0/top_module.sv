module top_module(
    input x,
    input y,
    output reg z
);

wire a1, b1, a2, b2, a3, b3;

// First gate
assign a1 = x;
assign b1 = y;
and(a1, b1, a3);

// Second gate
assign a2 = y;
assign b2 = x;
and(a2, b2, b3);

// Third gate
assign a3 = a1;
assign b3 = b2;
or(a3, b3, z);

endmodule
