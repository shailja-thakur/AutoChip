module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @*
	begin
		case(in)
			8'b0zzzzzzz: pos = 3'b0;
			8'b1zzzzzzz: pos = 3'b1;
			8'b01zzzzzz: pos = 3'b2;
			8'b11zzzzzz: pos = 3'b3;
			8'b001zzzzz: pos = 3'b4;
			8'b011zzzzz: pos = 3'b5;
			8'b101zzzzz: pos = 3'b6;
			8'b111zzzzz: pos = 3'b7;
			default: pos = 3'b0;
		endcase
	end

endmodule
