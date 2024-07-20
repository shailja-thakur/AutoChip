module top_module(
	input x,
	input y,
	output z);
	
	wire xor_result;
	
	xor_gate xor1(.a(x), .b(y), .out(xor_result));
	and_gate and1(.a(xor_result), .b(x), .out(z));
endmodule
module xor_gate(
	input a,
	input b,
	output out);
	
	assign out = a ^ b;
endmodule
module and_gate(
	input a,
	input b,
	output out);
	
	assign out = a & b;
endmodule
