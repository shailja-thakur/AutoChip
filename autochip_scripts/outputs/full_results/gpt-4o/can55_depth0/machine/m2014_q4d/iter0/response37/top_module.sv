module top_module (
	input clk,
	input in,
	output logic out
);
	reg out_reg;
	
	always @(posedge clk) begin
		out_reg <= out_reg ^ in;
	end
	
	assign out = out_reg;
	
	initial begin
		out_reg = 0;
	end
endmodule
