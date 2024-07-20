module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Declare internal wires for intermediate calculations
	wire [99:0] shifted_in;
	wire [99:0] tmp_out_both;
	wire [99:0] tmp_out_any;
	wire [99:0] tmp_out_different;
	
	// Shift input to the right by 1 bit
	// This will be used to compare each bit with its left neighbor
	assign shifted_in[99] = in[98];
	assign shifted_in[98:0] = in[99:1];
	
	// Calculate out_both for each bit by ANDing the input bit and its left neighbor
	genvar i;
	generate
		for (i = 0; i < 99; i = i+1) begin: out_both_gen
			assign tmp_out_both[i] = in[i] && shifted_in[i];
		end
	endgenerate
	
	// Calculate out_any for each bit by ORing the input bit and its right neighbor
	generate
		for (i = 1; i < 100; i = i+1) begin: out_any_gen
			assign tmp_out_any[i] = in[i] || in[i-1];
		end
	endgenerate
	
	// Calculate out_different for each bit by comparing the input bit with its left neighbor (taking into account wrapping around)
	generate
		for (i = 0; i < 100; i = i+1) begin: out_different_gen
			assign tmp_out_different[i] = in[i] != shifted_in[i];
		end
	endgenerate
	
	// Assign the temporary signals to the output ports
	assign out_both = tmp_out_both[98:0];
	assign out_any = tmp_out_any[99:1];
	assign out_different = tmp_out_different;
	
endmodule
