module top_module (
	input [31:0] in,
	output [31:0] out
);
	
	// Wire declarations
	wire [7:0] in_chunk[3:0];
	wire [7:0] out_chunk[3:0];
	
	genvar i;
	
	// Assigning input bits to 8-bit chunks
	generate
		for (i = 0; i < 4; i = i + 1) begin : CHUNK_ASSIGN
			assign in_chunk[i] = in[(i*8) +: 8];
		end
	endgenerate
	
	// Assigning output bits by rearranging input chunks
	assign out = {out_chunk[3], out_chunk[2], out_chunk[1], out_chunk[0]};
	
	// Assigning input chunks to output chunks in reverse order
	assign out_chunk[0] = in_chunk[3];
	assign out_chunk[1] = in_chunk[2];
	assign out_chunk[2] = in_chunk[1];
	assign out_chunk[3] = in_chunk[0];
	
endmodule
