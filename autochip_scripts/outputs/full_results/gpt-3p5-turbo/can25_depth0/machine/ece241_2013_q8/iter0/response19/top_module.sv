module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	reg [1:0] state, next_state;

	always @(posedge clk, negedge aresetn) begin
		if (~aresetn)
			state <= S;
		else
			state <= next_state;
	end
	
	always @(state, x) begin
		case (state)
			S: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S;
				z = 0;
			end
			
			S1: begin
				if (x == 0)
					next_state = S10;
				else
					next_state = S1;
				z = 0;
			end
			
			S10: begin
				if (x == 0)
					next_state = S;
				else
					next_state = S1;
				z = x;
			end
		endcase
	end
endmodule
