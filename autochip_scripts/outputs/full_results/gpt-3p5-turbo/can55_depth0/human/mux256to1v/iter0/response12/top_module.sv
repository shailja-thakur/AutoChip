module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Create a 4-bit wire to store the selected input
	wire [3:0] selected_input;

	// Logic to select the correct input based on the value of sel
	always @(*) begin
		case(sel)
			0: selected_input = in[3:0];
			1: selected_input = in[7:4];
			2: selected_input = in[11:8];
			// Add cases for the remaining selections
			
			default: selected_input = 4'b0; // Default case
		endcase
	end

	// Assign the selected input to the output
	assign out = selected_input;

endmodule
