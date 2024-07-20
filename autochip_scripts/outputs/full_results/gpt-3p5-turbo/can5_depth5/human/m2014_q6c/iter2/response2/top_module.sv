module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	// State set flip flops
	reg [5:0] state;

	always @(posedge w or negedge y) begin
		if (!y[6]) begin
			state <= 6'b000001; // Reset to A
		end else begin
			case (state)
				6'b000001: state <= y[5] ? 6'b000010 : 6'b000001; // A -> B, A -> A
				6'b000010: state <= y[5] ? 6'b000001 : 6'b001000; // A -> A, B -> D
				6'b000100: state <= y[5] ? 6'b001000 : 6'b010000; // B -> D, B -> C
				6'b001000: state <= y[5] ? 6'b010000 : 6'b100000; // B -> C, C -> E
				6'b010000: state <= y[5] ? 6'b100000 : 6'b001010; // C -> E, C -> D
				6'b100000: state <= y[5] ? 6'b001010 : 6'b100110; // C -> D, D -> F
				6'b001010: state <= y[5] ? 6'b100110 : 6'b100000; // D -> F, F -> C
				6'b100110: state <= y[5] ? 6'b100000 : 6'b000010; // F -> C, D -> A
				default: state <= 6'b000001; // Reset to A
			endcase
		end
	end

	// Output logic
	always @(state) begin
		Y2 <= (state == 6'b000010) | (state == 6'b000100) | (state == 6'b100110);
		Y4 <= (state == 6'b001000) | (state == 6'b010000);
	end

endmodule
