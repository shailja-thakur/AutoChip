module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // Initialize state to A
		else begin
			case (state)
				3'b000: // State A
					if (x)
						state <= 3'b001; // Next state is B
				3'b001: // State B
					if (x)
						state <= 3'b100; // Next state is E
				3'b100: // State E
					if (!x)
						state <= 3'b011; // Next state is D
				3'b011: // State D
					if (x)
						state <= 3'b010; // Next state is C
				3'b010: // State C
					if (!x)
						state <= 3'b010; // Next state is C
				default:
					state <= 3'b000; // Default state is A
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == 3'b100 || state == 3'b010) // Output is high for states D and E
			z <= 1'b1;
		else
			z <= 1'b0;
	end
endmodule
