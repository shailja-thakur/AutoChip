module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [255:0] temp;

	always @* begin
		case(sel)
			8'b0000: out = in[3:0];
			8'b0001: out = in[7:4];
			8'b0010: out = in[11:8];
			// extend the case statement for the remaining selections
			default: out = 4'b0;
		endcase
	end

endmodule
