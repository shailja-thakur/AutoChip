module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a temporary wire to store the selected input
	wire [255:0] selected_input;

	// Determine the index of the selected input
	always @*
	begin
		case(sel)
			0: selected_input = in[3:0]; // select bits [3:0]
			1: selected_input = in[7:4]; // select bits [7:4]
			2: selected_input = in[11:8]; // select bits [11:8]
			// Add more cases for the other selections
			default: selected_input = 0; // default case
		endcase
	end
	
	// Assign the output to the selected input
	assign out = selected_input[3:0];
endmodule
