module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

  assign sum = (a + b + cin) % 2;
  assign cout = (a + b + cin) >= 2;
  
endmodule
