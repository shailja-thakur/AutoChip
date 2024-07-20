module top_module(
  input [7:0] p1,
  output p1y,
  input [7:0] p2,
  output p2y
);

  // Define internal wires for connecting gates
  wire n1_out;
  wire n2_out;

  // Instantiate two 4-input NAND gates
  nand4 n1(
    .a(p1[0]),
    .b(p1[1]),
    .c(p1[2]),
    .d(p1[3]),
    .y(n1_out)
  );

  nand4 n2(
    .a(p2[0]),
    .b(p2[1]),
    .c(p2[2]),
    .d(p2[3]),
    .y(n2_out)
  );

  // Output connections
  assign p1y = n1_out;
  assign p2y = n2_out;

endmodule
