module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Wire declarations
	wire [98:0] temp_out_both;
	wire [99:1] temp_out_any;
	wire [99:0] temp_out_different;
	
	// Generate the out_both output
	genvar i;
	generate
		for (i = 0; i < 99; i = i + 1) begin : loop_out_both
			assign temp_out_both[i] = (in[i] & in[i+1]);
		end
	endgenerate
	
	// Generate the out_any output
	genvar j;
	generate
		for (j = 2; j < 100; j = j + 1) begin : loop_out_any
			assign temp_out_any[j] = (in[j] | in[j-1]);
		end
	endgenerate
	
	// Generate the out_different output
	genvar k;
	generate
		for (k = 0; k < 99; k = k + 1) begin : loop_out_different
			assign temp_out_different[k] = (in[k] !== in[(k+1) % 100]);
		end
	endgenerate
	
	// Assign outputs from temporary wires
	assign out_both = temp_out_both;
	assign out_any = temp_out_any;
	assign out_different = temp_out_different;
	
endmodule
