module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Declare the state register and assign the initial state A
	reg [1:0] state;
	assign state = 2'b00;

	// Declare the next state variable
	reg [1:0] next_state;

	// Assign next_state based on current state and input values
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset: state changes to A
			next_state <= 2'b00;
		end else begin
			case (state)
				2'b00: begin
					// State A
					if (in) begin
						// in is 1: state changes to B
						next_state <= 2'b01;
					end else begin
						// in is 0: state remains A
						next_state <= 2'b00;
					end
				end
				2'b01: begin
					// State B
					if (in) begin
						// in is 1: state remains B
						next_state <= 2'b01;
					end else begin
						// in is 0: state changes to C
						next_state <= 2'b10;
					end
				end
				2'b10: begin
					// State C
					if (in) begin
						// in is 1: state changes to D
						next_state <= 2'b11;
					end else begin
						// in is 0: state changes to A
						next_state <= 2'b00;
					end
				end
				2'b11: begin
					// State D
					if (in) begin
						// in is 1: state changes to B
						next_state <= 2'b01;
					end else begin
						// in is 0: state changes to C
						next_state <= 2'b10;
					end
				end
			endcase
		end
	end

	// Assign the current state based on next_state
	always @(posedge clk) begin
		state <= next_state;
	end

	// Assign the output based on the current state
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
