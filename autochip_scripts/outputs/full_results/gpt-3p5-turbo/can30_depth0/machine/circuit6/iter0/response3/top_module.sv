module top_module (
	input [2:0] a,
	output reg [15:0] q
);

	always @(a)
	begin
		case (a)
			3'b000: q = 16'h123A;
			3'b001: q = 16'hAE90;
			3'b010: q = 16'h27C4;
			3'b011: q = 16'h59EE;
			3'b100: q = 16'h205A;
			3'b101: q = 16'h644E;
			3'b110: q = 16'hC586;
			3'b111: q = 16'h2F19;
			default: q = 16'h0000;
		endcase
	end

endmodule
