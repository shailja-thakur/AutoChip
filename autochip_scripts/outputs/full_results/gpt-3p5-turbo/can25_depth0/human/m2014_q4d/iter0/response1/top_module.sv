module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic xor_out;
	flip_flop dff (
		.clk(clk),
		.in(xor_out),
		.out(out)
	);
	
	assign xor_out = in ^ out;
	
endmodule
module flip_flop (
	input clk,
	input in,
	output logic out
);
	
	logic d;
	
	always @(posedge clk) begin
		d <= in;
		out <= d;
	end
	
endmodule
