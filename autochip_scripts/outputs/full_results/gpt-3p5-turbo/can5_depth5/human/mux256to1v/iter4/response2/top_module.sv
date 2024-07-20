module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Create a temporary wire to store the selected input
	wire [255:0] selected_input;

	// Determine the index of the selected input
	always @* begin
		case(sel)
			0: selected_input = in[3:0];
			1: selected_input = in[7:4];
			2: selected_input = in[11:8];
			// Add more cases for the remaining selections
			default: selected_input = 256'b0; // Set default value to 0
		endcase
	end

	// Assign the output to the selected input
	assign out = selected_input;

endmodule
