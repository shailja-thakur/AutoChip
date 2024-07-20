module top_module (
	input clk,
	input in,
	output logic out
);
	reg out_reg = 0;
	
	always @(posedge clk) begin
		out_reg <= in ^ out_reg;
	end
	
	assign out = out_reg;
endmodule
