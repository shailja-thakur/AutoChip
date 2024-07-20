module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [3:0] temp_sel;

	always @* begin
		case (sel)
			0: temp_sel = in[3:0];
			1: temp_sel = in[7:4];
			2: temp_sel = in[11:8];
			// Add more cases for other values of sel if needed
			// ...
			default: temp_sel = 4'b0; // Default value for invalid sel
		endcase
	end

	assign out = temp_sel;

endmodule
