module d_flip_flop (
	input clk,
	input d,
	output reg q
);

	always @(posedge clk)
	begin
		q <= d;
	end
	
endmodule
module xor_gate (
	input a,
	input b,
	output reg y
);

	always @(*)
	begin
		y = a ^ b;
	end
	
endmodule
module top_module (
	input clk,
	input in,
	output logic out
);
	
	wire xor_out;
	reg q;

	d_flip_flop dff (.clk(clk), .d(xor_out), .q(q));
	xor_gate xor1 (.a(in), .b(q), .y(xor_out));
	
	assign out = q;
	
endmodule
