module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // Initializing the state to A
		end else begin
			case (state)
				3'b000: // State A
					if (x) begin
						state <= 3'b001; // Next state is B
					else
						state <= 3'b000; // Next state is A
					end
				3'b001: // State B
					if (x) begin
						state <= 3'b100; // Next state is E
					else
						state <= 3'b001; // Next state is B
					end
				3'b010: // State C
					if (x) begin
						state <= 3'b001; // Next state is B
					else
						state <= 3'b010; // Next state is C
					end
				3'b011: // State D
					if (x) begin
						state <= 3'b010; // Next state is C
					else
						state <= 3'b010; // Next state is B
					end
				3'b100: // State E
					if (x) begin
						state <= 3'b100; // Next state is E
					else
						state <= 3'b011; // Next state is D
					end
				default:
					state <= 3'b000;
			endcase
		end
	end

	always @(state) begin
		if (state == 3'b011 || state == 3'b100)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
endmodule
