module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states using local parameters
	parameter S = 0;
	parameter S1 = 1;
	parameter S10 = 2;
	
	// Define state and next_state registers
	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;    // Initialize state to S
		end else begin
			state <= next_state;    // Update state based on next_state
		end
	end
	
	always @* begin
		if (state == S) begin
			if (x == 0) begin
				next_state = S;
			end else begin
				next_state = S1;
			end
		end else if (state == S1) begin
			if (x == 0) begin
				next_state = S10;
			end else begin
				next_state = S1;
			end
		end else if (state == S10) begin
			if (x == 0) begin
				next_state = S;
			end else begin
				next_state = S1;
			end
		end
	end
	
	always @* begin
		if (state == S || state == S1) begin
			z = 0;
		end else if (state == S10) begin
			z = x;
		end
	end
	
endmodule
