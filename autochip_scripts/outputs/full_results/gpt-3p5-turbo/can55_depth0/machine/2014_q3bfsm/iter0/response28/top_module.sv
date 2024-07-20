module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b100; // Initializing the state to A
	else begin
		case(state)
			3'b100: // State A
				if (x)
					state <= 3'b010; // Next state B
				else
					state <= 3'b100; // Next state A
			3'b010: // State B
				if (x)
					state <= 3'b111; // Next state E
				else
					state <= 3'b010; // Next state B
			3'b001: // State C
				if (x)
					state <= 3'b010; // Next state B
				else
					state <= 3'b001; // Next state C
			3'b011: // State D
				if (x)
					state <= 3'b001; // Next state C
				else
					state <= 3'b010; // Next state B
			3'b110: // State E
				if (x)
					state <= 3'b110; // Next state E
				else
					state <= 3'b011; // Next state D
			default:
				state <= 3'b100; // Default case
		endcase
	end
end

always @(state) begin
	z = (state == 3'b110 || state == 3'b111); // Output is high when the state is D or E
end

endmodule
