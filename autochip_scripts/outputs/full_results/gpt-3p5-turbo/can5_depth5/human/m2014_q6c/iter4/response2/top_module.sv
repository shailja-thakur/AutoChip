module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	// State set flip flops
	reg [5:0] state;

	always @(posedge w) begin
		case (state)
			6'b000001: state <= 6'b000010; // A -> B
			6'b000010: state <= 6'b000001; // A -> A
			6'b000100: state <= 6'b001000; // B -> C
			6'b001000: state <= 6'b000100; // C -> D
			6'b010000: state <= 6'b100000; // E -> F
			6'b100000: state <= 6'b010000; // D -> E
			default: state <= 6'b000001;    // Reset to A
		endcase
	end

	// Output logic
	always @(state) begin
		Y2 <= (state == 6'b001000);
		Y4 <= (state == 6'b000100);
	end

endmodule
