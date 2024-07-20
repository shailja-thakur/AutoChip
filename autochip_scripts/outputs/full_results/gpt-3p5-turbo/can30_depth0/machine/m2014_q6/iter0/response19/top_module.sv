module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

	reg [2:0] state; // 3-bit register to store the current state

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000; // Reset to state A
		end else begin
			case (state)
				3'b000: begin // State A
					if (w) begin
						state <= 3'b000; // Transition to state A
					end else begin
						state <= 3'b001; // Transition to state B
					end
				end
				3'b001: begin // State B
					if (w) begin
						state <= 3'b010; // Transition to state D
					end else begin
						state <= 3'b011; // Transition to state C
					end
				end
				3'b010: begin // State C
					if (w) begin
						state <= 3'b010; // Transition to state D
					end else begin
						state <= 3'b100; // Transition to state E
					end
				end
				3'b011: begin // State D
					if (w) begin
						state <= 3'b000; // Transition to state A
					end else begin
						state <= 3'b101; // Transition to state F
					end
				end
				3'b100: begin // State E
					if (w) begin
						state <= 3'b010; // Transition to state D
					end else begin
						state <= 3'b100; // Transition to state E
					end
				end
				3'b101: begin // State F
						if (w) begin
							state <= 3'b010; // Transition to state D
						end else begin
							state <= 3'b011; // Transition to state C
						end
				end
			endcase
		end
	end

	always @(state) begin
		if (state == 3'b100 || state == 3'b101) begin
			z <= 1'b1; // Output z is high when state is E or F
		end else begin
			z <= 1'b0; // Output z is low otherwise
		end
	end

endmodule
