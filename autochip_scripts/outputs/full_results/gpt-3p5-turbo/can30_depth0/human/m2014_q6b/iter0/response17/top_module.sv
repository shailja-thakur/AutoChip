module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	reg Y2_next;

	always @(*) begin
		case (y)
			3'b000: Y2_next = ??;
			3'b001: Y2_next = ??;
			3'b010: Y2_next = ??;
			3'b011: Y2_next = ??;
			3'b100: Y2_next = ??;
			3'b101: Y2_next = ??;
		endcase
	end

	always @(posedge w) begin
		Y2 <= Y2_next;
	end
	
endmodule
