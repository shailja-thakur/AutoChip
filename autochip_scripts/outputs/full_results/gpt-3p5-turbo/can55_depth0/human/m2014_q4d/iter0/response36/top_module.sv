module top_module (
	input clk,
	input in,
	output logic out
);

	reg flipflop;

	always @(posedge clk) begin
		flipflop <= in ^ out;
	end
	
	assign out = flipflop;

endmodule
