module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output reg [3:0] out
);
	parameter WIDTH = 4;
	reg [WIDTH-1:0] mux_output;

	always @* begin
		case (sel)
			0: mux_output = in[WIDTH-1:0];
			1: mux_output = in[4*WIDTH-1:3*WIDTH];
			2: mux_output = in[8*WIDTH-1:7*WIDTH];
			3: mux_output = in[12*WIDTH-1:11*WIDTH];
			4: mux_output = in[16*WIDTH-1:15*WIDTH];
			5: mux_output = in[20*WIDTH-1:19*WIDTH];
			6: mux_output = in[24*WIDTH-1:23*WIDTH];
			7: mux_output = in[28*WIDTH-1:27*WIDTH];
			default: mux_output = 0;
		endcase
	end

	always @* begin
		case (sel)
			0: out = mux_output;
			1: out = mux_output;
			2: out = mux_output;
			3: out = mux_output;
			4: out = mux_output;
			5: out = mux_output;
			6: out = mux_output;
			7: out = mux_output;
			default: out = 0;
		endcase
	end

endmodule
