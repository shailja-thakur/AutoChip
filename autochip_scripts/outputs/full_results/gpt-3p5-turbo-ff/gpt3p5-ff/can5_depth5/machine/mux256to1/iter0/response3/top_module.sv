module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	reg [7:0] sel_reg;
	
	always @(*) begin
		sel_reg = sel;
	end
	
	assign out = in[sel_reg];
endmodule
