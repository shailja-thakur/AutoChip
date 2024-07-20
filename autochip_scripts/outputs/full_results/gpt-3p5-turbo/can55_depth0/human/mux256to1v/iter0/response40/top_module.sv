module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

// Create an intermediate signal to hold the selected 4-bit input
wire [3:0] selected_input;

// Use a for loop to concatenate the selected 4-bit inputs based on the selector value
always @(sel) begin
	case(sel)
		0: selected_input = in[3:0];
		1: selected_input = in[7:4];
		2: selected_input = in[11:8];
		// Add more cases for the remaining selector values
	endcase
end

// Assign the selected input to the output
assign out = selected_input;

endmodule
