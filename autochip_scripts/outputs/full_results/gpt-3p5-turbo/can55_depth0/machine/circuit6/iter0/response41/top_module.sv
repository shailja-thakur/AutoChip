module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @* begin
		case (a)
			3'b000: q = 16'h1234;
			3'b001: q = 16'hB020;
			3'b010: q = 16'h27EC;
			3'b011: q = 16'h59C6;
			3'b100: q = 16'h205A;
			3'b101: q = 16'h6456;
			3'b110: q = 16'hC4EE;
			3'b111: q = 16'h2F19;
		endcase
	end
endmodule
