module top_module (
	input a,
	input b,
	output sum,
	output cout
);

  // Declare internal wires for carry calculation
  wire c1;
  
  // Declare internal wires for sum calculation
  wire s1;
  
  // Perform addition operation
  assign {cout, sum} = a + b;
  
endmodule
