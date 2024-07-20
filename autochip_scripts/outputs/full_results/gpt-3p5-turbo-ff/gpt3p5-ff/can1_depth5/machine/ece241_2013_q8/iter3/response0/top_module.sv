module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	reg [1:0] next_state;
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			next_state <= S;
		else if (x == 0) begin
			case (state)
				S: next_state <= S;
				S1: next_state <= S10;
				S10: next_state <= S;
			endcase
		end else begin
			case (state)
				S: next_state <= S1;
				S1: next_state <= S1;
				S10: next_state <= S1;
			endcase
		end
	end
	
	reg [1:0] state;
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S;
		else
			state <= next_state;
	end
	
	always @(state) begin
		case (state)
			S: z <= 0;
			S1: z <= 0;
			S10: z <= x;
		endcase
	end
	
endmodule
