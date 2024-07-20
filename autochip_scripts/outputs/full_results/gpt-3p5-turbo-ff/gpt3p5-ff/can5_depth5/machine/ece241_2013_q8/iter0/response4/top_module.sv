module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	// Define the states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	// Define the state and next_state variables
	reg [1:0] state, next_state;
	
	// Initialize the state to S at reset
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	// Define the next_state based on input x and current state
	always @(*) begin
		case (state)
			S: begin
				if (x == 0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
			end
			S1: begin
				if (x == 0) begin
					next_state = S10;
				end else begin
					next_state = S1;
				end
			end
			S10: begin
				if (x == 0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
			end
		endcase
	end
	
	// Assign the output z based on the current state
	always @(*) begin
		case (state)
			S, S1: begin
				z = 0;
			end
			S10: begin
				z = x;
			end
		endcase
	end
	
endmodule
