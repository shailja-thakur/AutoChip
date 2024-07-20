module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic xor_output;
	
	xor_gate xor_inst (
		.a(in),
		.b(out),
		.z(xor_output)
	);
	
	flip_flop flip_flop_inst (
		.clk(clk),
		.d(xor_output),
		.q(out)
	);
	
endmodule
module xor_gate (
	input a,
	input b,
	output logic z
);
	
	assign z = a ^ b;
	
endmodule
module flip_flop (
	input clk,
	input d,
	output logic q
);
	reg q;
	
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
