module top_module (
  input a,
  input b,
  input cin,
  output cout,
  output sum
);
	
  reg sum;
  wire cout;

  assign {cout, sum} = a + b + cin;

endmodule
