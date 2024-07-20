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

  wire p1and1, p1and2, p2and1, p2and2;

  and #(3) u1 (
    .a(p1a),
    .b(p1b),
    .c(p1c),
    .out(p1and1)
  );

  and #(3) u2 (
    .a(p1d),
    .b(p1e),
    .c(p1f),
    .out(p1and2)
  );

  or #(2) u3 (
    .a(p1and1),
    .b(p1and2),
    .out(p1y)
  );

  and #(2) u4 (
    .a(p2a),
    .b(p2b),
    .out(p2and1)
  );

  and #(2) u5 (
    .a(p2c),
    .b(p2d),
    .out(p2and2)
  );

  or #(2) u6 (
    .a(p2and1),
    .b(p2and2),
    .out(p2y)
  );

endmodule
