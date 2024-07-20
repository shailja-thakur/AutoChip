module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// State variables
	reg [1:0] state;
	reg out_reg;

	// Initial state
	assign state = 2'b00;
	assign out = out_reg;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
		end else begin
			case (state)
				2'b00: begin // State A
					if (in) begin
						state <= 2'b01; // Transition to State B
					end else begin
						state <= 2'b00; // Remain in State A
					end
				end
				2'b01: begin // State B
					if (in) begin
						state <= 2'b01; // Remain in State B
					end else begin
						state <= 2'b10; // Transition to State C
					end
				end
				2'b10: begin // State C
					if (in) begin
						state <= 2'b11; // Transition to State D
					end else begin
						state <= 2'b00; // Transition to State A
					end
				end
				2'b11: begin // State D
					if (in) begin
						state <= 2'b01; // Transition to State B
					end else begin
						state <= 2'b10; // Transition to State C
					end
				end
				default: state <= 2'b00; // Default to State A
			endcase
		end
	end

	// Output logic
	always @(state) begin
		if (state == 2'b11) begin // State D
			out_reg <= 1;
		end else begin
			out_reg <= 0;
		end
	end

endmodule
