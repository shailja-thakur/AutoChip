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

	// Define state and next_state
	reg [1:0] state, next_state;

	// Define output z
	assign z = (state == S10) ? x : 1'b0;

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			// Asynchronous reset
			state <= S;
		end else begin
			// State transition logic
			case (state)
				S: begin
					if (x) begin
						next_state <= S1;
					end else begin
						next_state <= S;
					end
				end
				S1: begin
					if (x) begin
						next_state <= S1;
					end else begin
						next_state <= S10;
					end
				end
				S10: begin
					if (x) begin
						next_state <= S1;
					end else begin
						next_state <= S;
					end
				end
				default: next_state <= S; // Default state is S
			endcase
		end
	end

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			// Asynchronous reset
			state <= S;
		end else begin
			// Update state
			state <= next_state;
		end
	end

endmodule
