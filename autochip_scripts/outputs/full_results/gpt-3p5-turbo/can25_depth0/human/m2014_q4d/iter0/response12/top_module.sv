module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic xor_out;
	logic dff_out;

	xor_gate u1 (in, out, xor_out);
	d_flip_flop u2 (clk, xor_out, dff_out);
	
	assign out = dff_out;

endmodule
module xor_gate (
	input a,
	input b,
	output logic y
);
	
	assign y = a ^ b;

endmodule
module d_flip_flop (
	input clk,
	input d,
	output logic q
);
	
	always_ff @(posedge clk)
	begin
		q <= d;
	end

endmodule
