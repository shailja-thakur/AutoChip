module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a temporary wire to store the selected input
	wire [3:0] selected_input;

	// Determine the index of the selected input
	always @* begin
		case(sel)
			4'd0: selected_input = in[3:0];
			4'd1: selected_input = in[7:4];
			4'd2: selected_input = in[11:8];
			// Add the remaining cases for other selections
			//...
			default: selected_input = 4'bxxxx; // Consider handling the default case
		endcase
	end

	// Assign the output to the selected input
	assign out = selected_input;
endmodule
