module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	// Define the states
	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;
	
	// Define the present state and next state variables
	reg [2:0] present_state, next_state;
	
	// Synchronous reset to state 000
	always @(posedge clk or posedge reset) begin
		if (reset)
			present_state <= S0;
		else
			present_state <= next_state;
	end
	
	// Define the transition and output logic
	always @(present_state or x) begin
		case (present_state)
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
				z = 0;
			end
			S1: begin
				if (x)
					next_state = S4;
				else
					next_state = S1;
				z = 0;
			end
			S2: begin
				if (x)
					next_state = S1;
				else
					next_state = S2;
				z = 0;
			end
			S3: begin
				if (x)
					next_state = S2;
				else
					next_state = S1;
				z = 1;
			end
			S4: begin
				if (x)
					next_state = S4;
				else
					next_state = S3;
				z = 1;
			end
			default: begin
				next_state = S0;
				z = 0;
			end
		endcase
	end
	
endmodule
