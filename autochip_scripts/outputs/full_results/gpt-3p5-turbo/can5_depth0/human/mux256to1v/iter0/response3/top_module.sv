module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a 4-bit wire to extract the selected input from the input vector
	wire [3:0] selected_input;
	
	// Assign the selected input based on the sel signal
	always @* begin
		case (sel)
			0: selected_input = in[3:0];
			1: selected_input = in[7:4];
			2: selected_input = in[11:8];
			
			// Add cases for remaining selections
			
			default: selected_input = 4'b0; // Default case when sel is not within the valid range
		endcase
	end
	
	// Assign the selected input to the output
	assign out = selected_input;
endmodule
