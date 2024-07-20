module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);

	always @* begin
		case (sel)
			0: out = in[WIDTH-1:0];
			1: out = in[2*WIDTH-1:WIDTH];
			2: out = in[3*WIDTH-1:2*WIDTH];
			3: out = in[4*WIDTH-1:3*WIDTH];
			4: out = in[5*WIDTH-1:4*WIDTH];
			5: out = in[6*WIDTH-1:5*WIDTH];
			6: out = in[7*WIDTH-1:6*WIDTH];
			7: out = in[8*WIDTH-1:7*WIDTH];
			default: out = 0;
		endcase
	end

endmodule
