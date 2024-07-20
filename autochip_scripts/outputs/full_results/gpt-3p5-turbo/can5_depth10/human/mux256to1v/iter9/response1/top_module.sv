module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	always @* begin
		case (sel)
			0: out = in[4*sel +: 4];
			1: out = in[4*sel +: 4];
			2: out = in[4*sel +: 4];
			3: out = in[4*sel +: 4];
			4: out = in[4*sel +: 4];
			5: out = in[4*sel +: 4];
			6: out = in[4*sel +: 4];
			7: out = in[4*sel +: 4];
			default: out = 4'b0;
		endcase
	end
	
endmodule
