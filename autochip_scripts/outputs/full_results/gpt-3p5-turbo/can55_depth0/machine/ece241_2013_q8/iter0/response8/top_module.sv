module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;

	reg [1:0] current_state;
	reg [1:0] next_state;

	// State transition logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			current_state <= S;    // Reset state to S
		end else begin
			case ({x, current_state})
				2'b00: next_state <= S;    // x = 0, current_state = S
				2'b01: next_state <= S1;   // x = 1, current_state = S
				2'b10: next_state <= S10;  // x = 0, current_state = S1
				2'b11: next_state <= S1;   // x = 1, current_state = S1
			endcase
		end
	end

	// Output logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			z <= 1'b0;    // Reset output to 0
		end else begin
			case (current_state)
				S: z <= 1'b0;  // current_state = S
				S1: z <= 1'b0; // current_state = S1
				S10: z <= x;  // current_state = S10
			endcase
		end
	end

endmodule
