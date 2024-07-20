module top_module (
	input clk,
	input in,
	output logic out
);

	reg out;
	
	always_ff @(posedge clk) begin
		out <= in ^ out;
	end

endmodule
