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
	
	// Define state and next_state registers
	reg [1:0] state, next_state;
	
	// Assign initial state
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	// Define state transition logic
	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1'b0)
					next_state = S;
				else if (x == 1'b1)
					next_state = S1;
			end
			S1: begin
				if (x == 1'b0)
					next_state = S10;
				else if (x == 1'b1)
					next_state = S1;
			end
			S10: begin
				if (x == 1'b0)
					next_state = S;
				else if (x == 1'b1)
					next_state = S1;
			end
		endcase
	end
	
	// Define output logic
	always @(state) begin
		case (state)
			S, S1: z = 1'b0;
			S10: z = x;
		endcase
	end
endmodule
