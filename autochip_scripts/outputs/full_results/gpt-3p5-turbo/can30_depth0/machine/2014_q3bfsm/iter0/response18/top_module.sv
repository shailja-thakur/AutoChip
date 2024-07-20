module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // initializing state to A
		else begin
			case (state)
				3'b000: // state A
					if (x)
						state <= 3'b001; // next state is B
					else
						state <= 3'b000; // next state is A
				3'b001: // state B
					if (x)
						state <= 3'b100; // next state is E
					else
						state <= 3'b001; // next state is B
				3'b010: // state C
					if (x)
						state <= 3'b001; // next state is B
					else
						state <= 3'b010; // next state is C
				3'b011: // state D
					if (x)
						state <= 3'b010; // next state is C
					else
						state <= 3'b001; // next state is B
				3'b100: // state E
					if (x)
						state <= 3'b100; // next state is E
					else
						state <= 3'b011; // next state is D
				default:
					state <= 3'b000; // default state is A
			endcase
		end
	end

	always @(state) begin
		if (state == 3'b100 || state == 3'b101)
			z = 1'b1; // output is high when state is D or E
		else
			z = 1'b0;
	end
endmodule
