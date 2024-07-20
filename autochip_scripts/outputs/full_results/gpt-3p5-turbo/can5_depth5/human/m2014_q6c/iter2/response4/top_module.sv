module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	// State set flip flops
	reg [5:0] state;

	always @(posedge w or posedge y) begin
		case (state)
			6'b000001: state <= y == 6'b000010 ? 6'b000010 : 6'b000001; // A -> B or A -> A
			6'b000010: state <= y == 6'b000001 ? 6'b000001 : (y == 6'b001000 ? 6'b001000 : 6'b100000); // A -> A or A -> D or A -> C
			6'b000100: state <= y == 6'b001000 ? 6'b001000 : 6'b010000; // B -> D or B -> C
			6'b001000: state <= y == 6'b010000 ? 6'b010000 : (y == 6'b000100 ? 6'b000100 : 6'b100000); // B -> C or B -> B or  B -> E
			6'b010000: state <= y == 6'b100000 ? 6'b100000 : (y == 6'b001010 ? 6'b001010 : 6'b100110); // C -> E or C -> D or C -> F
			6'b100000: state <= y == 6'b001010 ? 6'b001010 : (y == 6'b010000 ? 6'b010000 : 6'b001000); // C -> D or C -> C or C -> B
			6'b001010: state <= y == 6'b100110 ? 6'b100110 : (y == 6'b100001 ? 6'b100001 : 6'b100000); // D -> F or D -> A or D -> C
			6'b100110: state <= y == 6'b100000 ? 6'b100000 : (y == 6'b001010 ? 6'b001010 : 6'b001000); // F -> C or F -> D or F -> B
			default: state <= 6'b000001; // Reset to A
		endcase
	end

	// Output logic
	always @(state) begin
		Y2 <= (state == 6'b000010) | (state == 6'b001000);
		Y4 <= (state == 6'b010000) | (state == 6'b100110);
	end

endmodule
