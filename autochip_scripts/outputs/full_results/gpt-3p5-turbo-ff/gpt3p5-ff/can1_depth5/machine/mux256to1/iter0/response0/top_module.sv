module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	
	reg [7:0] select_bit;
	always @(sel)
		select_bit = in[sel];
		
	assign out = select_bit;
	
endmodule
