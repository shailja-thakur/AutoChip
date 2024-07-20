module top_module (
  input [4:1] x,
  output logic f
);

// Intermediate wire declaration
wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14;

// Karnaugh map assignments
assign w1 = x[1] & x[2] & ~x[3] & ~x[4];
assign w2 = x[1] & ~x[2] & ~x[3] & ~x[4];
assign w3 = ~x[1] & ~x[2] & ~x[3] & ~x[4];
assign w4 = ~x[1] & ~x[2] & ~x[3] & x[4];
assign w5 = x[1] & x[2] & ~x[3] & ~x[4];
assign w6 = ~x[1] & x[2] & ~x[3] & ~x[4];
assign w7 = ~x[1] & x[2] & x[3] & ~x[4];
assign w8 = ~x[1] & ~x[2] & x[3] & x[4];
assign w9 = x[1] & x[2] & x[3] & ~x[4];
assign w10 = ~x[1] & ~x[2] & x[3] & ~x[4];
assign w11 = x[1] & ~x[2] & x[3] & ~x[4];
assign w12 = x[1] & x[2] & ~x[3] & x[4];
assign w13 = x[1] & ~x[2] & x[3] & x[4];
assign w14 = ~x[1] & x[2] & x[3] & x[4];

// f assignment
assign f = w1 | w2 | w3 | w4 | w5 | w6 | w7 | w8 | w9 | w10 | w11 | w12 | w13 | w14;

endmodule
