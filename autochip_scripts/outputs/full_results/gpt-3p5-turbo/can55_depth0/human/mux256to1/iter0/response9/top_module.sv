module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Define thewire
wire [255:0] selectedInput;

// Assign selected input based on sel
assign selectedInput = (sel < 256) ? in[sel] : 0;

// Create a 1-bit multiplexer using ternary operator
assign out = selectedInput[0];

endmodule
