module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	parameter WIDTH = 4;
	reg [3:0] mux_output;

	always @* begin
		case (sel)
			0: mux_output = in[3:0];
			1: mux_output = in[7:4];
			2: mux_output = in[11:8];
			3: mux_output = in[15:12];
			4: mux_output = in[19:16];
			5: mux_output = in[23:20];
			6: mux_output = in[27:24];
			7: mux_output = in[31:28];
			default: mux_output = 0;
		endcase
	end

	assign out = mux_output;

endmodule
