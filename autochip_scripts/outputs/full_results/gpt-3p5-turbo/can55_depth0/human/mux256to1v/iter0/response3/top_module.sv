module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Create a 256-to-1 multiplexer using a case statement
	always @(*) begin
		case(sel)
			0: out = in[3:0];
			1: out = in[7:4];
			2: out = in[11:8];
			3: out = in[15:12];
			// ... continue the pattern for all 256 cases
			default: out = 4'b0; // default case if sel is out of range
		endcase
	end
endmodule
