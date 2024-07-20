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

	reg [1:0] state_reg;
	reg [1:0] state_next;

	// Output assignments
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state_reg <= S;
		else
			state_reg <= state_next;
	end

	always @(state_reg or x) begin
		case (state_reg)
			S: begin
				if (x == 1)
					state_next = S1;
				else
					state_next = S;
				z = 0;
			end

			S1: begin
				if (x == 1)
					state_next = S1;
				else
					state_next = S10;
				z = 0;
			end

			S10: begin
				if (x == 1)
					state_next = S1;
				else
					state_next = S;
				z = x;
			end
		endcase
	end
	
endmodule
