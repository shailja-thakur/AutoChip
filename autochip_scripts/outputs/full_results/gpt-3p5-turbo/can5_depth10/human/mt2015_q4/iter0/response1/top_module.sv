module A (
	input x,
	input y,
	output z
);

	assign z = (x ^ y) & x;

endmodule
module B (
  input x,
  input y,
  output z
);

  reg z;

  initial begin
    #0 z = 1'b1;
    #20 z = 1'b0;
    #10 z = y;
    #40 z = (x & y);
    #5 z = (x ^ y);
    #5;
    #10 z = !(z & (x ^ y));
    #15 z = (x & y);
  end
  
  assign z_out = z;
  
endmodule
module top_module (
  input x,
  input y,
  output z
);

  wire a1, a2, b1, b2;
  
  A inst1 (
    .x(x),
    .y(y),
    .z(a1)
  );
  
  B inst2 (
    .x(x),
    .y(y),
    .z(b1)
  );
  
  A inst3 (
    .x(x),
    .y(y),
    .z(a2)
  );
  
  B inst4 (
    .x(x),
    .y(y),
    .z(b2)
  );
  
  wire or_out, and_out;
  
  assign or_out = a1 | b1;
  assign and_out = a2 & b2;
  
  assign z = or_out ^ and_out;
  
endmodule
