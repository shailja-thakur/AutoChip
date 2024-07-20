module top_module(
    input x,
    input y,
    output z
);

wire a1, b1, a2, b2, a3, b3;

// First logic gate
assign a1 = x;
assign b1 = y;

// Second logic gate
assign a2 = y;
assign b2 = x;

// Third logic gate
assign a3 = a1;
assign b3 = a2;

// Output
assign z = a3 & b3;

endmodule
