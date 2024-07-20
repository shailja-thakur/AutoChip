module top_module(
	input x,
	input y,
	output z);

	// Gates
	wire gate1_out;
	wire gate2_out;
	wire gate3_out;

	// First gate
	and gate1(x, ~y, gate1_out);

	// Second gate
	and gate2(~x, y, gate2_out);

	// Third gate
	or gate3(gate1_out, gate2_out, z);
      
endmodule
