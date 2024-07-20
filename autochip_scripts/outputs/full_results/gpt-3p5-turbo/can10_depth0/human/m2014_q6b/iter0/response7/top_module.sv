module top_module(
	input [3:1] y,
	input w,
	output reg Y2);
	
	always @(*) begin
		case(y)
			3'b000: Y2 = w;
			3'b001: Y2 = w;
			3'b010: Y2 = w;
			3'b011: Y2 = w;
			3'b100: Y2 = w;
			3'b101: Y2 = w;
		endcase
	end
	
endmodule
