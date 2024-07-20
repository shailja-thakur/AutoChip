module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);

	always @* begin
		case (sel)
			0: out = in[4*sel + 3:4*sel];
			1: out = in[4*sel + 3:4*sel];
			2: out = in[4*sel + 3:4*sel];
			3: out = in[4*sel + 3:4*sel];
			4: out = in[4*sel + 3:4*sel];
			5: out = in[4*sel + 3:4*sel];
			6: out = in[4*sel + 3:4*sel];
			7: out = in[4*sel + 3:4*sel];
			default: out = 4'b0;
		endcase
	end
	
endmodule
