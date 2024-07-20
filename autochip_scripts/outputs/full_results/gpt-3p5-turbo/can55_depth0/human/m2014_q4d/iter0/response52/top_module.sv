module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic xor_result;
	
	d_ff d_ff1 (
		.clk(clk),
		.d(xor_result),
		.q(out)
	);
	
	xor_gate xor_gate1 (
		.a(in),
		.b(out),
		.y(xor_result)
	);
	
endmodule
module d_ff (
	input clk,
	input d,
	output reg q
);
	
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
module xor_gate (
	input a,
	input b,
	output y
);
	
	assign y = a ^ b;
	
endmodule
