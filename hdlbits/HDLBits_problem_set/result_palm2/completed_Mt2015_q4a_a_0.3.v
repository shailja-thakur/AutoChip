module top_module (
  input wire x,
  input wire y,
  output wire z
);

  assign z = (x ^ y) & x;

endmodule