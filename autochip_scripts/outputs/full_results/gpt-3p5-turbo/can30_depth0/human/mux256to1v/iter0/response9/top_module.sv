module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a 4-bit wire for each 4-bit input
	wire [3:0] in_chunk [255:0];
	
	// Split the 1024-bit input into 256 4-bit chunks
	generate
		genvar i;
		for (i = 0; i < 256; i = i + 1) begin : IN_SPLIT
			assign in_chunk[i] = in[i * 4 +: 4];
		end
	endgenerate
	
	// Create a 4-bit input wire for the selected input chunk
	wire [3:0] selected_in;
	
	// Select the appropriate input chunk based on the value of sel
	always @* begin
		case (sel)
			0: selected_in = in_chunk[0];
			1: selected_in = in_chunk[1];
			2: selected_in = in_chunk[2];
			3: selected_in = in_chunk[3];
			...
			default: selected_in = in_chunk[255];
		endcase
	end
	
	// Assign the selected input to the output
	assign out = selected_in;
	
endmodule
