module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

	reg [7:0] out_reg;
	
	always @(sel) begin
		out_reg <= in[sel];
	end
	
	assign out = out_reg;
	
endmodule
