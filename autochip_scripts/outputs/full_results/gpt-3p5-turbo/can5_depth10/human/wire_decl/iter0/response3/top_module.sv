module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Intermediate wires
	wire and1_out;
	wire and2_out;

	// AND gates
	assign and1_out = a & b;
	assign and2_out = c & d;
	
	// OR gate
	assign out = and1_out | and2_out;
	
	// Inverter for out_n
	assign out_n = ~out;

endmodule
