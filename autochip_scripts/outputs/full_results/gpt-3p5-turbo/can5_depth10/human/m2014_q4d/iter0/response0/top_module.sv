module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic flip_flop;
	logic xor_out;
	
	always_ff @(posedge clk)
	begin
		xor_out <= in ^ flip_flop;
		flip_flop <= xor_out;
	end
	
	assign out = flip_flop;
	
endmodule
