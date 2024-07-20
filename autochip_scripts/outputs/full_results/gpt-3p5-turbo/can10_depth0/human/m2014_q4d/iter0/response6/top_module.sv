module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic flip_flop_q;
	
	always_ff @(posedge clk)
	begin
		flip_flop_q <= xor(in, out);
	end
	
	assign out = flip_flop_q;
	
endmodule
