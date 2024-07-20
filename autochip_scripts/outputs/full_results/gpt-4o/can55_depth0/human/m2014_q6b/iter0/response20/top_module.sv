module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*) begin
		case (y)
			3'b000: Y2 = 0; // State A (y = 000) has Y2 = 0
			3'b001: Y2 = w ? 1 : 0; // State B (y = 001): w==0 goes to 010 (C), w==1 goes to 011 (D) which have Y2 = 0 and 1 respectively
			3'b010: Y2 = w ? 1 : 1; // State C (y = 010): w==0 goes to 100 (E), w==1 goes to 011 (D) which have Y2 = 1 and 1 respectively
			3'b011: Y2 = w ? 0 : 1; // State D (y = 011): w==0 goes to 101 (F), w==1 goes to 000 (A) which have Y2 = 1 and 0 respectively
			3'b100: Y2 = 1; // State E (y = 100) has Y2 = 1
			3'b101: Y2 = w ? 1 : 0; // State F (y = 101): w==0 goes to 010 (C), w==1 goes to 011 (D) which have Y2 = 0 and 1 respectively
			default: Y2 = 0; // Default case
		endcase
	end
endmodule
