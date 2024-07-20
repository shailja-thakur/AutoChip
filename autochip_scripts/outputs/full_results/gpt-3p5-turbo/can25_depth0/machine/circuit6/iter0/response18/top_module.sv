module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @* begin
		case (a)
			3'b000: q = 16'h123A;
			3'b001: q = 16'hAFF0;
			3'b010: q = 16'h2774;
			3'b011: q = 16'h59F6;
			3'b100: q = 16'h206A;
			3'b101: q = 16'h6426;
			3'b110: q = 16'hC5CE;
			3'b111: q = 16'h2F79;
		endcase
	end

endmodule
