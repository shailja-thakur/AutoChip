module top_module (
	input [3:0] in,
	output reg [3:0] pos
);

always @(*)
begin
	case(in)
		4'b0001: pos = 4'b0001;
		4'b0010: pos = 4'b0010;
		4'b0100: pos = 4'b0100;
		4'b1000: pos = 4'b1000;
		default: pos = 4'b0000;
	endcase
end

endmodule
