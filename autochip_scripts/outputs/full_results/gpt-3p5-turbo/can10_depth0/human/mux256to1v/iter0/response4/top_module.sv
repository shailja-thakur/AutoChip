module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	/* Declare intermediate wires */
	wire [255:0] mux_outputs;
	
	/* Instantiate 256-to-1 multiplexer */
	mux256 mux(
		.in(in[sel*4 +: 4]),
		.sel(sel),
		.out(mux_outputs)
	);
	
	/* Assign output */
	assign out = mux_outputs;
	
endmodule
module mux256 (
	input [3:0] in,
	input [7:0] sel,
	output reg [3:0] out
);
	
	always @(sel)
	begin
		case (sel)
			0: out = in;
			1: out = in;
			2: out = in;
			3: out = in;
			4: out = in;
			5: out = in;
			6: out = in;
			7: out = in;
			default: out = 4'b0;
		endcase
	end
	
endmodule
