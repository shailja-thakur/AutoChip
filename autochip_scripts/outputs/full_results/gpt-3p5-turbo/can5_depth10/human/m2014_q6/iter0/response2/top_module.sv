module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Declare state variables
	reg [2:0] state;
	reg [1:0] out;

	// Declare next state variable
	reg [2:0] next_state;

	// Declare output variable
	reg z;

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset state to A
			state <= 3'b000;
		end else begin
			// Update next state based on current state and inputs
			case (state)
				3'b000: begin
					if (w) begin
						next_state <= 3'b001; // Next state: B
					end else begin
						next_state <= 3'b000; // Next state: A
					end
				end
				3'b001: begin
					if (w) begin
						next_state <= 3'b011; // Next state: D
					end else begin
						next_state <= 3'b010; // Next state: C
					end
				end
				3'b010: begin
					if (w) begin
						next_state <= 3'b011; // Next state: D
					end else begin
						next_state <= 3'b100; // Next state: E
					end
				end
				3'b011: begin
					if (w) begin
						next_state <= 3'b000; // Next state: A
					end else begin
						next_state <= 3'b101; // Next state: F
					end
				end
				3'b100: begin
					if (w) begin
						next_state <= 3'b011; // Next state: D
					end else begin
						next_state <= 3'b100; // Next state: E
					end
				end
				3'b101: begin
					if (w) begin
						next_state <= 3'b010; // Next state: C
					end else begin
						next_state <= 3'b101; // Next state: F
					end
				end
				default: begin
					next_state <= 3'b000; // Default next state: A
				end
			endcase

			// Update state and output
			state <= next_state;
			case (state)
				3'b101: begin
					out <= 2'b01; // Output: 1
				end
				default: begin
					out <= 2'b00; // Output: 0
				end
			endcase
		end
	end

	// Output logic
	assign z = out[1];

endmodule
