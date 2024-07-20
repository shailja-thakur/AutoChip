module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;

	// Sequential logic for state transition
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000; // Initializing state to A
		end else begin
			case (state)
				3'b000: begin
					if (x)
						state <= 3'b001; // Next state is B
					else
						state <= 3'b000; // Next state is A
				end
				3'b001: begin
					if (x)
						state <= 3'b100; // Next state is E
					else
						state <= 3'b001; // Next state is B
				end
				3'b010: begin
					if (x)
						state <= 3'b001; // Next state is B
					else
						state <= 3'b010; // Next state is C
				end
				3'b011: begin
					if (x)
						state <= 3'b001; // Next state is B
					else
						state <= 3'b011; // Next state is D
				end
				3'b100: begin
					if (x)
						state <= 3'b100; // Next state is E
					else
						state <= 3'b101; // Next state is D
				end
				default: state <= 3'b000; // Default to state A
			endcase
		end
	end

	// Combinational logic for output z
	always @(*) begin
		case (state)
			3'b011, 3'b100, 3'b101: z = 1'b1; // Output is high for states D and E
			default: z = 1'b0; // Output is low for other states
		endcase
	end
	
endmodule
