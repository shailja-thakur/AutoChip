module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @* begin
	case(in)
		8'b0zzzzzzz1: pos = 3'b000;
		8'bz1zzzzzz0: pos = 3'b110;
		default: pos = 3'b000;
	endcase
end

endmodule
