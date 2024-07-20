module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create an array to hold the 256 4-bit inputs
	reg [3:0] inputs [0:255];

	// Assign the values of each 4-bit input from the input vector
	// based on the value of sel
	generate
		genvar i;
		for (i = 0; i < 256; i = i + 1) begin : assign_inputs
			assign inputs[i] = in[(i*4)+3:(i*4)];
		end
	endgenerate

	// Create a variable to hold the selected input based on sel value
	reg [3:0] selected_input;

	// Assign the selected input based on the value of sel
	always @(sel) begin
		case (sel)
			0: selected_input = inputs[0];
			1: selected_input = inputs[1];
			2: selected_input = inputs[2];
			3: selected_input = inputs[3];
			4: selected_input = inputs[4];
			5: selected_input = inputs[5];
			6: selected_input = inputs[6];
			7: selected_input = inputs[7];
			default: selected_input = 4'b0; // Default value when sel is out of range
		endcase
	end

	// Assign the selected input to the output
	assign out = selected_input;
endmodule
