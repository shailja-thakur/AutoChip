module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	parameter A = 0, B = 1, C = 2, D = 3;
	reg [1:0] state, next_state;
	reg out;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @* begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
				out = 0;
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
				out = 0;
			end
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
				out = 0;
			end
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
				out = 1;
			end
			default: begin
				next_state = A;
				out = 0;
			end
		endcase
	end
	
endmodule
