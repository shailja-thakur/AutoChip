module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [3:0] state, next_state;
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
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
				if (x == 1) begin
					next_state = S1;
				end else begin
					next_state = S;
				end
			end
			S1: begin
				if (x == 0) begin
				    next_state = S10;
				end else begin
					next_state = S1;
				end
			end
			S10: begin
				if (x == 1) begin
					next_state = S1;
				end else begin
					next_state = S;
				end
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			S, S1: begin
				z <= 0;
			end
			S10: begin
				z <= x;
			end
		endcase
	end
endmodule
