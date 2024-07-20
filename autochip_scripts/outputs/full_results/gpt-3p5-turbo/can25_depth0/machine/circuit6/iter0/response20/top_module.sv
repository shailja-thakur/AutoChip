module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @*
	begin
		case (a)
			3'b000: q = 16'h1234;
			3'b001: q = 16'haaaa;
			3'b010: q = 16'h2014;
			3'b011: q = 16'h59fe;
			3'b100: q = 16'h205a;
			3'b101: q = 16'h643e;
			3'b110: q = 16'hc50e;
			3'b111: q = 16'h2f79;
		endcase
	end
	
endmodule
