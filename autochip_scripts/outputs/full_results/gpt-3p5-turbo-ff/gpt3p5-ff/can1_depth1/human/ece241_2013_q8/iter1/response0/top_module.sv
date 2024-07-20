module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	always @(state, x) begin
		case (state)
			S0: begin
				if (x == 1'b1)
					next_state <= S1;
				else
					next_state <= S0;
			end
			S1: begin
				if (x == 1'b0)
					next_state <= S0;
				else
					next_state <= S2;
			end
			S2: begin
				if (x == 1'b1)
					next_state <= S1;
				else
					next_state <= S0;
			end
		endcase
	end
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			z <= 1'b0;
		else begin
			if (state == S2)
				z <= 1'b1;
			else
				z <= 1'b0;
		end
	end
	
endmodule
