module top_module (
	input [2:0] in,
	output [1:0] out
);
	// Declare internal wires for the circuit
	wire [2:0] in_xor;
	wire xor1;
	wire xor2;
	wire and1;
	
	// Logic for the population count circuit
	assign in_xor[0] = in[0] ^ in[1];
	assign in_xor[1] = in[1] ^ in[2];
	assign in_xor[2] = in[0] ^ in[2];
	
	assign xor1 = in_xor[0] ^ in_xor[1];
	assign xor2 = in_xor[1] ^ in_xor[2];
	
	assign and1 = xor1 & xor2;
	
	assign out = {and1, xor1};
	
endmodule
