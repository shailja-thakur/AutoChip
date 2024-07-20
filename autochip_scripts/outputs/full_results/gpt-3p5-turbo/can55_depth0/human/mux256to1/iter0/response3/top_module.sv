module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);
	// Define local variables
	reg [7:0] index;

	// Assign index based on sel value
	always @(*) begin
		case (sel)
			0: index = 0;
			1: index = 1;
			2: index = 2;
			// Continue adding cases till 255
			default: index = 255;
		endcase
	end

	// Assign output based on selected input
	assign out = in[index];

endmodule
