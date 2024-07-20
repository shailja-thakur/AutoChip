module top_module (
	input [7:0] in,
	output reg [2:0] pos
);

	always @(in) begin
		casez(in)
			8'bzz0zzzzz: pos <= 3'b0;
			8'bzz1zzzzz: pos <= 3'b1;
			8'bzzz0zzzz: pos <= 3'b2;
			8'bzzz1zzzz: pos <= 3'b3;
			8'bzzzz0zzz: pos <= 3'b4;
			8'bzzzz1zzz: pos <= 3'b5;
			8'bzzzzz0zz: pos <= 3'b6;
			default: pos <= 3'b0;
		endcase
	end

endmodule
