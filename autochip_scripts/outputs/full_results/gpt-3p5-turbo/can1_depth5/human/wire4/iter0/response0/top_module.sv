module top_module (
	input a,
	input b,
	input c,
	output w,
	output x,
	output y,
	output z  );
  
  wire w;
  wire x;
  wire y;
  wire z;

  assign w = a;
  assign x = b;
  assign y = b;
  assign z = c;

endmodule
