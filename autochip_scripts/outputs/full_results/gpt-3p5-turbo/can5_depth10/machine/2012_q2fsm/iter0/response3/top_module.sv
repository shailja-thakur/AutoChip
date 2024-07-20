module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// Declare state register
	reg [2:0] state;

	// State machine logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;  // Initial state is A
		end else begin
			case (state)
				3'b000: begin  // State A
					if (w) begin
						state <= 3'b001;  // Transition to B
					end else begin
						state <= 3'b000;  // Stay in A
					end
				end
				3'b001: begin  // State B
					if (w) begin
						state <= 3'b010;  // Transition to C
					end else begin
						state <= 3'b100;  // Transition to D
					end
				end
				3'b010: begin  // State C
					if (w) begin
						state <= 3'b110;  // Transition to E
					end else begin
						state <= 3'b100;  // Transition to D
					end
				end
				3'b100: begin  // State D
					if (w) begin
						state <= 3'b011;  // Transition to F
					end else begin
						state <= 3'b000;  // Transition to A
					end
				end
				3'b011: begin  // State E
					if (w) begin
						state <= 3'b011;  // Stay in E
					end else begin
						state <= 3'b100;  // Transition to D
					end
				end
				3'b110: begin  // State F
					if (w) begin
						state <= 3'b010;  // Transition to C
					end else begin
						state <= 3'b100;  // Transition to D
					end
				end
				default: state <= 3'b000;  // Default to state A
			endcase
		end
	end

	// Output logic
	assign z = (state == 3'b011) || (state == 3'b110);

endmodule
