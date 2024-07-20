module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S = 0;
	parameter S1 = 1;
	parameter S10 = 2;
	
	reg [1:0] state_reg;
	reg [1:0] state_next;
	
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
			end
			
			S1: begin
				if (x == 0)
					state_next = S10;
				else
					state_next = S1;
			end
			
			S10: begin
				if (x == 1)
					state_next = S1;
				else
					state_next = S;
			end
		endcase
	end
	
	always @(state_reg) begin
		case (state_reg)
			S, S1: begin
				z = 0;
			end
			
			S10: begin
				z = x;
			end
		endcase
	end
	
endmodule
