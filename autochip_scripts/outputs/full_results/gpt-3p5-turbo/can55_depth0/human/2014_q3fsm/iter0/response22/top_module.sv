module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	parameter A = 0;
	parameter B = 1;
	reg state, next_state;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or w) begin
		next_state = state;
		case (state)
			A: if (s) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			B: begin
					if (w) begin
						if (w === 2'b10 || w === 2'b01) begin
							z <= 1;
						end else begin
							z <= 0;
						end
					end else if (w === 2'b00) begin
						next_state = A;
					end
				end
		endcase
	end
endmodule
