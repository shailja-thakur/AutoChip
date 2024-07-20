module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	reg [1:0] state;
	reg prev_x;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0; // Reset state
		else begin
			prev_x <= x;
			case (state)
				S0: begin
					// Transition to S1 if "1" is detected
					if (x && !prev_x)
						state <= S1;
					else
						state <= S0;
				end
				S1: begin
					// Transition to S2 if "0" is detected
					if (!x && prev_x)
						state <= S2;
					else
						state <= S1;
				end
				S2: begin
					// Transition to S1 if "1" is detected
					if (x && !prev_x)
						state <= S1;
					else
						state <= S2;
				end
			endcase
		end
	end

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			z <= 1'b0; // Reset output
		else begin
			case (state)
				S0: z <= 1'b0; // Output is 0 in S0
				S1: z <= 1'b0; // Output is 0 in S1
				S2: z <= 1'b1; // Output is 1 in S2 (when "101" sequence is detected)
			endcase
		end
	end

endmodule
