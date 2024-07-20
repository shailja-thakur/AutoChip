module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	
	reg [255:0] selected_bit;
	
	always @* begin
		selected_bit = in[sel];
	end
	
	assign out = selected_bit;
	
endmodule
