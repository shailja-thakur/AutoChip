module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// state register
	reg [2:0] state_reg;

	// next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= 3'b000; // initial state is A
		end else begin
			case (state_reg)
			3'b000: state_reg <= w ? 3'b000 : 3'b001; // state A
			3'b001: state_reg <= w ? 3'b001 : 3'b010; // state B
			3'b010: state_reg <= w ? 3'b011 : 3'b100; // state C
			3'b011: state_reg <= w ? 3'b001 : 3'b100; // state D
			3'b100: state_reg <= w ? 3'b101 : 3'b101; // state E
			3'b101: state_reg <= w ? 3'b100 : 3'b010; // state F
			endcase
		end
	end

	// output logic
	always @(state_reg, w) begin
		case (state_reg)
		3'b000: z = 1'b0; // state A
		3'b001: z = 1'b0; // state B
		3'b010: z = 1'b0; // state C
		3'b011: z = 1'b0; // state D
		3'b100: z = 1'b1; // state E
		3'b101: z = 1'b0; // state F
		endcase
	end
	
endmodule
