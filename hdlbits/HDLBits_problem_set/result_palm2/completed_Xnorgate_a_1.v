module top_module(
  input wire a,
  input wire b,
  output wire out);

  XNOR gate1 (
    .a(a),
    .b(b),
    .y(out));

endmodule