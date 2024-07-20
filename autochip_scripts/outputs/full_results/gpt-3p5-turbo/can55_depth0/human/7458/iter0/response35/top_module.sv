module top_module(
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  input p1e,
  input p1f,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);

wire p1g, p1h, p2e, p2f;

// OR gate for p1y
assign p1g = p1a & p1b & p1c;
assign p1h = p1d & p1e & p1f;
assign p1y = p1g | p1h;

// OR gate for p2y
assign p2e = p2a & p2b;
assign p2f = p2c & p2d;
assign p2y = p2e | p2f;

endmodule
