module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	/*----------------- Code Here -----------------*/

	assign q = (a | b) & (c | d);

	/*---------------------------------------------------*/
endmodule
