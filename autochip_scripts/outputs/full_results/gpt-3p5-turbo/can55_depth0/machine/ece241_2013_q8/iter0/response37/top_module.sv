module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	parameter S11 = 2'b11;
	
	reg current_state;
	reg next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			current_state <= S;
		end else begin
			current_state <= next_state;
		end
	end
	
	always @(current_state or x) begin
		case (current_state)
			S: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S;
				end
			end
			S1: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S10;
				end
			end
			S10: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S;
				end
			end
			default: next_state = S;
		endcase
	end
	
	always @(*) begin
		case (current_state)
			S, S1: z = 1'b0;
			S10: z = x;
			default: z = 1'b0;
		endcase
	end

endmodule
