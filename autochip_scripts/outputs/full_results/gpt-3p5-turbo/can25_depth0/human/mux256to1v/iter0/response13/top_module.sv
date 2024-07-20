module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Define internal signals and variables
	wire [255:0] in_sel;
	wire [3:0] out_sel;

	// Assign values to in_sel based on sel
	genvar i;
	generate
		for (i = 0; i < 256; i = i + 1) begin : gen_for
			assign in_sel[i] = in[i*4 +: 4];
		end
	endgenerate

	// Assign values to out_sel based on sel
	always @* begin
		case(sel)
			0: out_sel = in_sel[0];
			1: out_sel = in_sel[1];
			2: out_sel = in_sel[2];
			3: out_sel = in_sel[3];
			4: out_sel = in_sel[4];
			5: out_sel = in_sel[5];
			6: out_sel = in_sel[6];
			7: out_sel = in_sel[7];
			default: out_sel = 4'b0;
		endcase
	end

	// Assign values to out
	assign out = out_sel;

endmodule
