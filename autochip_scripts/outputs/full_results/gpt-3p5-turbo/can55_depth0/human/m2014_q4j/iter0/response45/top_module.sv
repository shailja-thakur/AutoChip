module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Define internal signals
	wire [3:0] carry;
	
	// Instantiate full adders
	full_adder FA0(x[0], y[0], 1'b0, sum[0], carry[0]);
	full_adder FA1(x[1], y[1], carry[0], sum[1], carry[1]);
	full_adder FA2(x[2], y[2], carry[1], sum[2], carry[2]);
	full_adder FA3(x[3], y[3], carry[2], sum[3], carry[3]);
	
	// The last carry bit is the overflow bit
	assign sum[4] = carry[3];
	
endmodule
module full_adder (
	input a,
	input b,
	input c_in,
	output sum,
	output c_out
);
	// Intermediate signals
	wire h1, h2, h3;
	
	// Calculate sum and carry out
	xor_gate XOR1(a, b, h1);
	xor_gate XOR2(h1, c_in, sum);
	and_gate AND1(a, b, h2);
	and_gate AND2(h1, c_in, h3);
	or_gate OR1(h2, h3, c_out);
	
endmodule
module xor_gate (
	input a,
	input b,
	output y
);
	assign y = a ^ b;
endmodule
module and_gate (
	input a,
	input b,
	output y
);
	assign y = a & b;
endmodule
module or_gate (
	input a,
	input b,
	output y
);
	assign y = a | b;
endmodule
