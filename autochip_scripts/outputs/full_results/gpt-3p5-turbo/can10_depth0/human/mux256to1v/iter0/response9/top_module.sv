module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a register to hold the selected input
	reg [3:0] selected_input;
	
	// Select the input based on the value of sel
	always @(*) begin
		case (sel)
			0: selected_input = in[3:0];
			1: selected_input = in[7:4];
			2: selected_input = in[11:8];
			// Add more cases for sel=3, sel=4, etc.
			default: selected_input = 4'bxxxx; // Invalid selection
		endcase
	end
	
	// Assign the selected input to the output
	assign out = selected_input;

endmodule
