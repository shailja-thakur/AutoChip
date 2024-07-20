module top_module (
  input a,
  input b,
  output sum,
  output cout
);
	// Declare internal wires
	wire [1:0] temp;
  	wire carry_out;

	// Assign sum and carry_out
	assign {cout, sum} = a + b;

endmodule
