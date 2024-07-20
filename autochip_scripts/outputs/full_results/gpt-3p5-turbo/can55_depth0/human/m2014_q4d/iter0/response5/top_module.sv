module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic xor_out;
	dff_1bit flipflop (
		.clk(clk),
		.in(xor_out),
		.out(out)
	);
	
	xor2_gate xor_gate (
		.in1(in),
		.in2(out),
		.out(xor_out)
	);
	
endmodule
module dff_1bit (
	input clk,
	input in,
	output reg out
);
	
	always @(posedge clk)
	begin
		out <= in;
	end
	
endmodule
module xor2_gate (
	input in1,
	input in2,
	output out
);
	
	assign out = in1 ^ in2;
	
endmodule
