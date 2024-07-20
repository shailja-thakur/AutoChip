module top_module (
	input [7:0] in,
	output parity
);

reg [7:0] data;
reg computed_parity;

// Assign input to data
assign data = in;

// Compute parity bit using XOR operation
always @(data)
	computed_parity = ^data;

// Assign computed_parity to output
assign parity = computed_parity;

endmodule
