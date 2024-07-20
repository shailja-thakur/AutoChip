module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	assign q = b | c;  //performing OR operation between inputs b and c
endmodule
