module top_module (
	input [255:0] in,
	input [7:0] sel,
	output out
);

wire [7:0] sel_extended;
assign sel_extended = sel;

// Declare an intermediate wire
wire [255:0] selected_bit;
assign selected_bit = (sel_extended == 8'b0) ? in[0] : in[sel_extended];

// Declare the output bit
assign out = selected_bit;
endmodule
