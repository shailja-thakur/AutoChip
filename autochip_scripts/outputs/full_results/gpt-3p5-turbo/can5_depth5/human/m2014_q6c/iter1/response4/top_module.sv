module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State set flip flops
	reg [5:0] state;

	always @(posedge w) begin
		case (state)
			6'b000001: state <= 6'b000010; // A -> B
			6'b000010: state <= 6'b000001; // A -> A
			6'b000100: state <= 6'b001000; // B -> D
			6'b001000: state <= 6'b010000; // B -> C
			6'b010000: state <= 6'b100000; // C -> E
			6'b100000: state <= 6'b001010; // C -> D
			6'b001010: state <= 6'b101010; // D -> F
			6'b100010: state <= 6'b100100; // E -> D
			6'b100110: state <= 6'b010000; // F -> C
			default: state <= 6'b000001; // Reset to A
		endcase
	end

	// Output logic
	assign Y2 = (state == 6'b000100) | (state == 6'b100010);
	assign Y4 = (state == 6'b001000) | (state == 6'b100110);

endmodule
