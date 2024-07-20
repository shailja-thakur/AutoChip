module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	reg [2:0] state;
	
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= 3'b0;
		else begin
			case (state)
				3'b000: begin // State A
					if (x)
						state <= 3'b001; // Next state B
					else
						state <= 3'b000; // Next state A
				end

				3'b001: begin // State B
					if (x)
						state <= 3'b100; // Next state E
					else
						state <= 3'b001; // Next state B
				end

				3'b010: begin // State C
					if (x)
						state <= 3'b001; // Next state B
					else
						state <= 3'b010; // Next state C
				end

				3'b011: begin // State D
					if (x)
						state <= 3'b010; // Next state C
					else
						state <= 3'b001; // Next state B
				end

				3'b100: begin // State E
					if (x)
						state <= 3'b100; // Next state E
					else
						state <= 3'b011; // Next state D
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			3'b011, 3'b100: z <= 1'b1; // Output is high for state D and E
			default: z <= 1'b0;
		endcase
	end
endmodule
