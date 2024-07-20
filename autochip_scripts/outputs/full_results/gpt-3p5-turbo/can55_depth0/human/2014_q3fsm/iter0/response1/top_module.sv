module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00; // Reset state A
	end else begin
		case(state)
			2'b00: begin // State A
				if (s == 0) begin
					state <= 2'b00; // Stay in state A
				end else begin
					state <= 2'b01; // Transition to state B
				end
			end
			
			2'b01: begin // State B
				state <= 2'b10; // Transition to state C
			end
			
			2'b10: begin // State C
				state <= 2'b11; // Transition to state D
			end
			
			2'b11: begin // State D
				state <= 2'b01; // Transition back to state B
			end
		endcase
	end
end

always @(posedge clk) begin
	case(state)
		2'b01: begin // State B - check w for two 1's in the next three clock cycles
			if (w) begin
				state <= 2'b10;
			end else begin
				state <= 2'b01;
			end
		end
		
		2'b10: begin // State C - check w for two 1's in the next three clock cycles
			if (w) begin
				state <= 2'b10;
			end else begin
				state <= 2'b11;
			end
		end
		
		2'b11: begin // State D - check w for two 1's in the next three clock cycles
			if (w) begin
				state <= 2'b01;
				z <= 1; // Set output z to 1 in the following clock cycle
			end else begin
				state <= 2'b11;
				z <= 0; // Set output z to 0
			end
		end
	endcase
end

endmodule
