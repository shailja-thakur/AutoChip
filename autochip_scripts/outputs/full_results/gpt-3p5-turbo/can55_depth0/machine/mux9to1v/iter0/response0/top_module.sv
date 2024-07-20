module top_module (
	input [15:0] a,
	input [15:0] b,
	input [15:0] c,
	input [15:0] d,
	input [15:0] e,
	input [15:0] f,
	input [15:0] g,
	input [15:0] h,
	input [15:0] i,
	input [3:0] sel,
	output logic [15:0] out
);

	always @* begin
		case(sel)
			4'b0000: out <= a; // sel = 0
			4'b0001: out <= b; // sel = 1
			4'b0010: out <= c; // sel = 2
			4'b0011: out <= d; // sel = 3
			4'b0100: out <= e; // sel = 4
			4'b0101: out <= f; // sel = 5
			4'b0110: out <= g; // sel = 6
			4'b0111: out <= h; // sel = 7
			4'b1000: out <= i; // sel = 8
			default: out <= 16'b0000000000000001; // Default value
		endcase
	end

endmodule
