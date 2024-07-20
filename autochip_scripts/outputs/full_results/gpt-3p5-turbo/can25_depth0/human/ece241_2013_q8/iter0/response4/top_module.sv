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
	
	// Output register
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Next-state logic
	reg [1:0] next_state;
	always @(state or x) begin
		case (state)
			S0: begin
				if (x == 1'b1)
					next_state <= S1;
				else
					next_state <= S0;
			end
			S1: begin
				if (x == 1'b0)
					next_state <= S2;
				else
					next_state <= S0;
			end
			S2: begin
				if (x == 1'b1)
					next_state <= S1;
				else
					next_state <= S0;
			end
			default: next_state <= S0;
		endcase
	end
	
	// Output logic
	reg z_output;
	always @(state) begin
		if (state == S2)
			z_output <= 1'b1;
		else
			z_output <= 1'b0;
	end
	
	// Synchronous assignment to z
	always @(posedge clk) begin
		if (~aresetn)
			z <= 1'b0;
		else
			z <= z_output;
	end

endmodule
