module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

always @* begin
	case (a)
		3'b000: q = 16'd1232;
		3'b001: q = 16'hAEE0;
		3'b010: q = 16'h27D4;
		3'b011: q = 16'h5A0E;
		3'b100: q = 16'h2066;
		3'b101: q = 16'h64CE;
		3'b110: q = 16'hC526;
		3'b111: q = 16'h2F19;
	endcase
end

endmodule
