module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	// State set flip flops
	reg [5:0] state;

	always @(posedge w or y) begin // Added y in sensitivity list
		case (state)
			6'b000001: state <= y[6:1]; // A -> B
			6'b000010: state <= y[6:1]; // A -> A
			6'b000100: state <= y[6:1]; // B -> C
			6'b001000: state <= y[6:1]; // C -> D
			6'b010000: state <= y[6:1]; // D -> F
			6'b100000: state <= y[6:1]; // F -> B
			default: state <= 6'b000001; // Reset to A
		endcase
	end

	// Output logic
	always @(state) begin
		Y2 <= (state == 6'b000100);
		Y4 <= (state == 6'b001000);
	end

endmodule
