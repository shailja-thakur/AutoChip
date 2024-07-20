module top_module (
	input [2:0] a, 
	output reg [15:0] q
);
	
	always @* begin
		case (a)
			3'b000: q = 16'd1232;
			3'b001: q = 16'daee0;
			3'b010: q = 16'd27d4;
			3'b011: q = 16'd5a0e;
			3'b100: q = 16'd2066;
			3'b101: q = 16'd64ce;
			3'b110: q = 16'dc526;
			3'b111: q = 16'd2f19;
			default: q = 0;
		endcase
	end
	
endmodule
