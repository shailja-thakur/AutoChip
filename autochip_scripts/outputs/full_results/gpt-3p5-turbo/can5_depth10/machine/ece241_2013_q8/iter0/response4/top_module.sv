module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S = 0;
	parameter S1 = 1;
	parameter S10 = 2;
	
	reg state, next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1'b0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
			end
			
			S1: begin
				if (x == 1'b0) begin
					next_state = S10;
				end else begin
					next_state = S1;
				end
			end
			
			S10: begin
				if (x == 1'b0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			S, S1: begin
				z = 1'b0;
			end
			S10: begin
				z = x;
			end
		endcase
	end

endmodule
