module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

always @* begin
	case(in)
		8'b0zzzzzzz1: pos = 3'b000;   // Case correction
		8'b1zzzzzzz0: pos = 3'b010;   // New case added
		8'b1zzzzzzz1: pos = 3'b011;   // New case added
		8'b1zzzzzzz: pos = 3'b110;    // Case correction
		default: pos = 3'b000;
	endcase
end

endmodule
