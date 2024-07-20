module top_module (
  input wire c,
  input wire d,
  output wire [3:0] mux_in
);

  wire [1:0] a;
  wire [1:0] b;
  wire [3:0] y_wire;

  and #(2) U1(ab_00, ~c, ~d); // ab = 00
  and #(2) U2(ab_01, c, ~d);  // ab = 01
  and #(2) U3(ab_11, c, d);   // ab = 11
  and #(2) U4(ab_10, c, ~d);  // ab = 10

  mux4to1 U5(
    .a(a),
    .b(b),
    .s({ab_00, ab_01, ab_11, ab_10}),
    .y(y_wire)
  );
    
endmodule
module mux4to1 (
  input wire [1:0] a,
  input wire [1:0] b,
  input wire [3:0] s,
  output wire [3:0] y
);

  wire [3:0] y_wire;

  assign y = y_wire;

  mux2to1 U1(
    .a(a[0]),
    .b(b[0]),
    .s(s[0]),
    .y(y_wire[0])
  );

  mux2to1 U2(
    .a(a[1]),
    .b(b[1]),
    .s(s[1]),
    .y(y_wire[1])
  );

  mux2to1 U3(
    .a(a[2]),
    .b(b[2]),
    .s(s[2]),
    .y(y_wire[2])
  );

  mux2to1 U4(
    .a(a[3]),
    .b(b[3]),
    .s(s[3]),
    .y(y_wire[3])
  );
    
endmodule
module mux2to1 (
  input wire a,
  input wire b,
  input wire s,
  output wire y
);

  assign y = a & ~s | b & s;
    
endmodule
