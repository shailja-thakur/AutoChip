module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	reg [3:0] mux_out;

	always @(*) begin
		case(sel)
			8'b00000000: mux_out = in[3:0];
			8'b00000001: mux_out = in[7:4];
			8'b00000010: mux_out = in[11:8];
			// add more cases for other values of sel if required
			default: mux_out = 4'bxxxx; // handle sel values out of range
		endcase
	end

	assign out = mux_out;

endmodule
