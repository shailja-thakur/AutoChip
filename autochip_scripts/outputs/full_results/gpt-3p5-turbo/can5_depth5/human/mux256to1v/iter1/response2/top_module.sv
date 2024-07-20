module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);

	// Create a temporary wire to store the selected input
	wire [255:0] selected_input;

	// Determine the index of the selected input
	always @* begin
		case(sel)
			0: selected_input = in[3:0];
			1: selected_input = in[7:4];
			2: selected_input = in[11:8];
			// Add cases for remaining values of sel
			default: selected_input = in[(sel+1)*4 +: 4]; // Assuming remaining cases increment sel by 1
		endcase
	end

	// Assign the output to the selected input
	always @* begin
		out = selected_input[3:0];
	end
endmodule
