module top_module (
	input [7:0] in,
	output [31:0] out
);
	genvar i;
	assign out = {24{in}};
	
	generate
		for (i = 0; i < 24; i = i + 1) begin : repeat_input
			assign out[i*8 +: 8] = in;
		end
	endgenerate
endmodule
