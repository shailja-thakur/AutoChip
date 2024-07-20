module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @(a) begin
		case (a)
			3'b000: q = 16'h1232;
			3'b001: q = 16'hAF80;
			3'b010: q = 16'h281C;
			3'b011: q = 16'h59AE;
			3'b100: q = 16'h205A;
			3'b101: q = 16'h6426;
			3'b110: q = 16'hC5C6;
			3'b111: q = 16'h2F79;
		endcase
	end

endmodule
