module top_module (
	 input a, 
	 input b, 
	 input c, 
	 input d,
	 output q
	);
	assign q = b | c; // Perform logical OR operation between inputs b and c to produce output q
endmodule
