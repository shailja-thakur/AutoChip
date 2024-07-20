module top_module (
	input [2:0] a, 
	output reg [15:0] q
);

	always @*
	begin
		case (a)
			3'b000: q <= 16'b0000000000010010;
			3'b001: q <= 16'b0000000000101110;
			3'b010: q <= 16'b0000000001001110;
			3'b011: q <= 16'b0000000000100000;
			3'b100: q <= 16'b0000000001100010;
			default: q <= 16'b0000000001001110;
		endcase
	end
endmodule
