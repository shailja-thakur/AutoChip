module top_module(
    input x,
    input y,
    output z
);

wire a1, b1, a2, b2, a3, b3;

// First gate
assign a1 = x;
assign b1 = y;

// Second gate
assign a2 = y;
assign b2 = x;

// Third gate
assign a3 = a1;
assign b3 = a2;

assign z = a3 & b3;

endmodule
