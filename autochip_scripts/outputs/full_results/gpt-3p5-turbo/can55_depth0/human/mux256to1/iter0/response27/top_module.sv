module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

// Internal wire declaration
wire [7:0] mux_out;

// Instantiate the multiplexer module
mux256 #(
	.WIDTH(256),
	.SELECT_WIDTH(8)
) mux (
	.in(in),
	.sel(sel),
	.out(mux_out)
);

// Output assignment
assign out = mux_out;

endmodule
module mux256 (
	input [255:0] in,
	input [7:0] sel,
	output reg [7:0] out
);
	
	// Case statement to select the output based on the value of sel
	always @(sel) begin
		case(sel)
			0: out = in[0];
			1: out = in[1];
			2: out = in[2];
			// Add more cases for the remaining inputs
			default: out = in[255];
		endcase
	end
	
endmodule
