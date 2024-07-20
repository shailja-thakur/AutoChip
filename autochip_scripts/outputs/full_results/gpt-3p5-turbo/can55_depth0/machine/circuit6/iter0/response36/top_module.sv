module top_module (
	input [2:0] a, 
	output reg [15:0] q
);
	always @(a) begin
		case (a)
			3'b000: q = 16'h1232;
			3'b001: q = 16'haf80;
			3'b010: q = 16'h27fc;
			3'b011: q = 16'h59ae;
			3'b100: q = 16'h205a;
			3'b101: q = 16'h64d6;
			3'b110: q = 16'hc4d6;
			3'b111: q = 16'h2f49;
			default: q = 16'h0000;
		endcase
	end
endmodule
