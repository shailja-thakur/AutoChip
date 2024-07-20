module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	reg [2:0] state;
	reg [2:0] next_state;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b000;
		else
			state <= next_state;
	end

	always @(*)
	begin
		case(state)
			3'b000:  // State A
				if (w == 1)
					next_state = 3'b000;  // Next state A
				else
					next_state = 3'b001;  // Next state B
			3'b001:  // State B
				if (w == 1)
					next_state = 3'b010;  // Next state D
				else
					next_state = 3'b011;  // Next state C
			3'b010:  // State C
				if (w == 1)
					next_state = 3'b011;  // Next state D
				else
					next_state = 3'b100;  // Next state E
			3'b011:  // State D
				if (w == 1)
					next_state = 3'b000;  // Next state A
				else
					next_state = 3'b101;  // Next state F
			3'b100:  // State E
				if (w == 1)
					next_state = 3'b101;  // Next state F
				else
					next_state = 3'b100;  // Next state E
			3'b101:  // State F
				if (w == 1)
					next_state = 3'b011;  // Next state D
				else
					next_state = 3'b010;  // Next state C
			default:
				next_state = 3'b000;
		endcase
	end

	always @(posedge clk)
	begin
		if (reset)
			z <= 0;
		else if (state == 3'b100)
			z <= 1;
		else
			z <= 0;
	end

endmodule
