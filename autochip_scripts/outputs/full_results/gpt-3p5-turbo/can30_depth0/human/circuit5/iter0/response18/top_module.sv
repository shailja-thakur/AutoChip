module top_module (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @* begin
  if (a == b)
    q[0] = 1;
  else if (c == e)
    q[0] = b[0];
  else if (d == e)
    q[0] = e[0];
  else if (a == c)
    q[0] = d[0];
  else
    q[0] = f[0];
end

endmodule
