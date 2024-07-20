module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	// State set flip flops
	reg [5:0] state;

	always @ (posedge w) begin
		case (state)
			6'b000001: state <= 6'b000010; // A -> B
			6'b000010: state <= 6'b000001; // A -> A
			6'b000100: state <= 6'b001000; // B -> D
			6'b001000: state <= 6'b010000; // B -> C
			6'b010000: state <= 6'b100000; // C -> E
			6'b100000: state <= 6'b001000; // C -> D
			6'b001010: state <= 6'b001010; // D -> F (unchanged)
			6'b100010: state <= 6'b100100; // E -> D
			6'b100110: state <= 6'b100000; // F -> C
			default: state <= 6'b000001; // Reset to A
		endcase
	end

	// Output logic
	always @ (state) begin
		case (state)
			6'b000100, 6'b100010: Y2 <= 1; // B or E
			default: Y2 <= 0;
		endcase
	end
	
	always @ (state) begin
		case (state)
			6'b001000, 6'b100110: Y4 <= 1; // C or F
			default: Y4 <= 0;
		endcase
	end

endmodule
