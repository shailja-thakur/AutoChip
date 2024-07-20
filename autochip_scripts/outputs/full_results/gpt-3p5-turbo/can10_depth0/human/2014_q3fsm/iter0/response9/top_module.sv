module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	reg [1:0] state, next_state;
	parameter A = 0, B = 1, C = 2;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state, w) begin
		case (state)
			A: begin
				if (s) begin
					next_state = B;
				end else begin
					next_state = A;
				end
				z <= 0;
			end
			B: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = B;
				end
				z <= 0;
			end
			C: begin
				if (w) begin
					next_state = B;
				end else begin
					next_state = C;
				end
				if (w) begin
					z <= 1;
				end else begin
					z <= 0;
				end
			end
		endcase
	end
	
endmodule
