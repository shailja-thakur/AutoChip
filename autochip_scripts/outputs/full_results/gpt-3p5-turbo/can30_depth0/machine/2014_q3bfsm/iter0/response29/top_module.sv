module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

	reg [2:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;   // Initialize state to A when reset is high
		else begin
			case (state)
				3'b000: begin   // State A
					if (x)
						state <= 3'b010;   // Next state is B when x is high
					else
						state <= 3'b000;   // Next state is A when x is low
				end
				3'b001: begin   // State B
					if (x)
						state <= 3'b100;   // Next state is E when x is high
					else
						state <= 3'b001;   // Next state is B when x is low
				end
				3'b010: begin   // State C
					if (x)
						state <= 3'b001;   // Next state is B when x is high
					else
						state <= 3'b010;   // Next state is C when x is low
				end
				3'b011: begin   // State D
					if (x)
						state <= 3'b010;   // Next state is C when x is high
					else
						state <= 3'b001;   // Next state is B when x is low
				end
				3'b100: begin   // State E
					if (x)
						state <= 3'b100;   // Next state is E when x is high
					else
						state <= 3'b011;   // Next state is D when x is low
				end
				default: state <= 3'b000;   // Default to state A if none of the above conditions are met
			endcase
		end
	end

	always @(state)
		if (state == 3'b100 || state == 3'b101)
			z <= 1'b1;   // Output is high when the state is D or E
		else
			z <= 1'b0;   // Otherwise, output is low

endmodule
