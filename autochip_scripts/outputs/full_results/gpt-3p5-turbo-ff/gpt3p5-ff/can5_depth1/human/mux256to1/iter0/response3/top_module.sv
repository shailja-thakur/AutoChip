module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);


reg [255:0] out_reg;


always @(*) begin
	case(sel)
		0: out_reg = in[0];
		1: out_reg = in[1];
		2: out_reg = in[2];
		// ...
		255: out_reg = in[255];
		default: out_reg = 0;
	endcase
end


assign out = out_reg;


endmodule
