module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	parameter B = 1'b0;
	parameter A = 1'b1;
	
	reg state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state, in) begin
		case (state)
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			
			A: begin
				if (in) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			
			default: begin
				next_state = B;
			end
		endcase
	end
	
	assign out = state;
endmodule
