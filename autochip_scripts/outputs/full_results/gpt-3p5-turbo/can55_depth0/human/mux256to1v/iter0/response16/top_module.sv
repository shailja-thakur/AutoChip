module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	wire [255:0] mux_out;
	
	genvar i;
	generate
		for (i = 0; i < 256; i=i+1) begin : mux_blk
			assign mux_out[i] = in[i*4 +: 4];
		end
	endgenerate
	
	assign out = mux_out[sel];
endmodule
