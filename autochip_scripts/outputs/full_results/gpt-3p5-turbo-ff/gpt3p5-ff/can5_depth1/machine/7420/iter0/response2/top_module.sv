module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);

	// Internal signals
	wire p1_and_result;
	wire p2_and_result;

	// AND gates for p1y and p2y
	andgate and1(p1_and_result, p1a, p1b, p1c, p1d);
	andgate and2(p2_and_result, p2a, p2b, p2c, p2d);

	// Inverter for p1y and p2y outputs
	notgate inv1(p1y, p1_and_result);
	notgate inv2(p2y, p2_and_result);

endmodule
module andgate(output y, input a, input b, input c, input d);
	assign y = a & b & c & d;
endmodule
module notgate(output y, input a);
	assign y = ~a;
endmodule
