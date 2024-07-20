module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Create a wire for each sel option
	wire [255:0] in_sel;
	assign in_sel = in[sel*256 +: 256];

	// Create a wire for each bit in the output
	wire [3:0] out_bits;
	assign out = out_bits;

	// Create the multiplexer
	always @*
	begin
		case(sel)
			0: out_bits = in_sel[3:0];
			1: out_bits = in_sel[7:4];
			2: out_bits = in_sel[11:8];
            // Add more cases for remaining options
			default: out_bits = 4'b0; // Default case
		endcase
	end

endmodule
