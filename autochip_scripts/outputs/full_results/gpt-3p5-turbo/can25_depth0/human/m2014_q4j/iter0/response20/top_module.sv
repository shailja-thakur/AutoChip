module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  wire [3:0] g;
  wire [3:0] p;
  wire [3:0] c;
  wire [4:0] s;

  assign g[0] = x[0] & y[0];
  assign p[0] = x[0] ^ y[0];
  assign s[0] = p[0] ^ c[0];
  assign c[1] = g[0] | (p[0] & c[0]);

  assign g[1] = x[1] & y[1];
  assign p[1] = x[1] ^ y[1];
  assign s[1] = p[1] ^ c[1];
  assign c[2] = g[1] | (p[1] & c[1]);

  assign g[2] = x[2] & y[2];
  assign p[2] = x[2] ^ y[2];
  assign s[2] = p[2] ^ c[2];
  assign c[3] = g[2] | (p[2] & c[2]);

  assign g[3] = x[3] & y[3];
  assign p[3] = x[3] ^ y[3];
  assign s[3] = p[3] ^ c[3];
  assign c[4] = g[3] | (p[3] & c[3]);

  assign s[4] = c[4];

  assign sum = s;

endmodule
