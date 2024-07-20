module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @*
	begin
		case (a)
			3'b000: q = 16'h1236;
			3'b001: q = 16'hada0;
			3'b010: q = 16'h27ec;
			3'b011: q = 16'h59e6;
			3'b100: q = 16'h205a;
			3'b101: q = 16'h6426;
			3'b110: q = 16'hc516;
			3'b111: q = 16'h2f49;
		endcase
	end
endmodule
