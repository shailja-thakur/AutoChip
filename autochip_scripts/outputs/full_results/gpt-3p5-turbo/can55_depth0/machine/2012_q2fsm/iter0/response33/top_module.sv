module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // initial state is A
		else begin
			case({state, w})
				3'b000_0: state <= 3'b000; // A to A
				3'b001_1: state <= 3'b001; // A to B
				3'b010_0: state <= 3'b010; // B to C
				3'b010_1: state <= 3'b011; // B to D
				3'b011_0: state <= 3'b100; // C to E
				3'b011_1: state <= 3'b011; // C to D
				3'b100_0: state <= 3'b100; // D to E
				3'b100_1: state <= 3'b101; // D to F
				3'b101_0: state <= 3'b100; // E to E
				3'b101_1: state <= 3'b110; // E to F
				3'b110_0: state <= 3'b100; // F to E
				3'b110_1: state <= 3'b010; // F to C
				default: state <= 3'b000; // default to A
			endcase
		end
	end

	assign z = (state == 3'b100) || (state == 3'b110); // set z to 1 when state is E or F

endmodule
