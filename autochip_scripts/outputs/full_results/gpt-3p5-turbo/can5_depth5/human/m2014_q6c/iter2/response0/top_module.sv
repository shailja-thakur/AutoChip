module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	// State set flip flops
	reg [5:0] state;
	wire w1, w2, w3, w4, w5, w6;

	always @(posedge w) begin
		case (state)
			6'b000001: state <= 6'b000010; // A -> B
			6'b000010: state <= 6'b000001; // A -> A
			6'b000100: state <= 6'b001000; // B -> D
			6'b001000: state <= 6'b010000; // B -> C
			6'b010000: state <= 6'b100000; // C -> E
			6'b100000: state <= 6'b001010; // C -> D
			6'b001010: state <= 6'b100110; // D -> F
			6'b100110: state <= 6'b100000; // F -> C
			default: state <= 6'b000001; // Reset to A
		endcase
	end

	// Output logic
	assign w1 = (y == 6'b000100); 
	assign w2 = (y == 6'b100010);
	assign w3 = (y == 6'b001000);
	assign w4 = (y == 6'b100110);

	always @(state) begin
		Y2 <= w1 | w2;
		Y4 <= w3 | w4;
	end

endmodule
