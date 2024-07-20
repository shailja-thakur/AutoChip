module top_module (
	input [255:0] in,
	input [7:0] sel,
	output reg out
);

always @* begin
	case (sel)
		8'h00: out = in[0];
		8'h01: out = in[1];
		8'h02: out = in[2];
		// ...
		8'hFF: out = in[255];
	endcase
end

endmodule
