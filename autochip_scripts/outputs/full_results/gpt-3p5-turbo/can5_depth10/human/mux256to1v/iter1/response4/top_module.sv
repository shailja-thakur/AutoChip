module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	parameter WIDTH = 4;
	reg [WIDTH-1:0] mux_output;

	always @(sel) begin
		case (sel)
			0: mux_output <= in[WIDTH-1:0];
			1: mux_output <= in[2*WIDTH-1:WIDTH];
			2: mux_output <= in[3*WIDTH-1:2*WIDTH];
			3: mux_output <= in[4*WIDTH-1:3*WIDTH];
			4: mux_output <= in[5*WIDTH-1:4*WIDTH];
			5: mux_output <= in[6*WIDTH-1:5*WIDTH];
			6: mux_output <= in[7*WIDTH-1:6*WIDTH];
			7: mux_output <= in[8*WIDTH-1:7*WIDTH];
			default: mux_output <= 0;
		endcase
	end

	assign out = mux_output;

endmodule
