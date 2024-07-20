module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S = 0;
	parameter S1 = 1;
	parameter S10 = 2;
	
	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	always @* begin
		case (state)
			S: begin
				if (x == 0) begin
					next_state = S;
				end else if (x == 1) begin
					next_state = S1;
				end
				z = 0;
			end
			
			S1: begin
				if (x == 0) begin
					next_state = S10;
				end else if (x == 1) begin
					next_state = S1;
				end
				z = 0;
			end
			
			S10: begin
				if (x == 0) begin
					next_state = S;
				end else if (x == 1) begin
					next_state = S1;
				end
				z = x;
			end
		endcase
	end
	
endmodule
