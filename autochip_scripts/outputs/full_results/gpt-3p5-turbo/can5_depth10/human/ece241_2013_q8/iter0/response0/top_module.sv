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
	parameter S3 = 2'b11;
	
	// Define current state
	reg [1:0] state;
	
	// Define next state
	reg [1:0] next_state;
	
	// Synchronous reset
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Combinational logic to calculate next state and output
	always @(state or x) begin
		case (state)
			S0: begin
				if (x)
					next_state <= S1;
				else
					next_state <= S0;
				z <= 0;
			end
			S1: begin
				if (x)
					next_state <= S1;
				else
					next_state <= S2;
				z <= 0;
			end
			S2: begin
				if (x)
					next_state <= S3;
				else
					next_state <= S0;
				z <= 0;
			end
			S3: begin
				if (x)
					next_state <= S1;
				else
					next_state <= S2;
				z <= 1;
			end
		endcase
	end
	
endmodule
