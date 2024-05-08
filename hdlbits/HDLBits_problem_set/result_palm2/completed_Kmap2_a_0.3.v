module top_module (
  input wire a,
  input wire b,
  input wire c,
  input wire d,
  output wire out
);

  assign out = (a'b' + ab' + cd')(a'b + ab + cd);

endmodule