module top_module(
  input x,
  input y,
  output z
);

// Internal wire declaration
wire w1;

// XOR gate
assign w1 = x ^ y;

// AND gate
assign z = w1 & x;

endmodule
