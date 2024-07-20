module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a 256-to-1 multiplexer using a case statement
	always @*
	begin
		case(sel)
			0: out = in[3:0];
			1: out = in[7:4];
			2: out = in[11:8];
			// Add more cases to cover all possibilities
			default: out = 4'b0; // Return 0 if sel is out of range
		endcase
	end
endmodule
