module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create wire to hold selected input vector
	wire [255:0] selected_input;

	// Create wire to hold selected bits from input vector
	wire [3:0] selected_bits;

	// Assign selected bits based on sel value
	assign selected_bits = {in[sel*4+3], in[sel*4+2], in[sel*4+1], in[sel*4]};

	// Create 256-to-1 multiplexer
	genvar i;
	generate
		for(i=0; i<256; i=i+1) begin :mux
			assign selected_input[i] = (sel == i) ? selected_bits : 4'b0;
		end
	endgenerate

	// Assign output to selected input
	assign out = selected_input[out];
endmodule
