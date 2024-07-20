module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State register
	reg [1:0] state;
	// Next state
	reg [1:0] next_state;

	// Define the states
	parameter S0 = 2'b00;  // Initial state
	parameter S1 = 2'b01;  // '1' detected
	parameter S2 = 2'b10;  // '10' detected

	// Asynchronous reset
	always @(negedge aresetn) begin
		if (~aresetn) begin
			state <= S0;
		end
	end

	// Sequential logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S0;
		end
		else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(state, x) begin
		case (state)
			S0: begin
				if (x == 1'b1) begin
					next_state = S1;
				end
				else begin
					next_state = S0;
				end
			end

			S1: begin
				if (x == 1'b0) begin
					next_state = S2;
				end
				else begin
					next_state = S1;
				end
			end

			S2: begin
				if (x == 1'b1) begin
					next_state = S1;
					z = 1'b1;
				end
				else begin
					next_state = S0;
				end
			end
		endcase	
	end

endmodule
