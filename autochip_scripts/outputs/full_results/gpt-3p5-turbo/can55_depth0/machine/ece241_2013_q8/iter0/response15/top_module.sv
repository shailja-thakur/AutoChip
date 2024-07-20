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
	
	reg [1:0] state, next_state;
	
	// Default state and next_state values
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
			next_state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always @(*) begin
		case (state)
			S: begin
				if (x == 1) begin
					next_state = S1;
				end else begin
					next_state = S;
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
				if (x == 1) begin
					next_state = S1;
				end else begin
					next_state = S;
				end
			end
		endcase
	end
	
	// Output logic
	always @(state) begin
		case (state)
			S, S1: z <= 0;
			S10: z <= x;
		endcase
	end

endmodule
