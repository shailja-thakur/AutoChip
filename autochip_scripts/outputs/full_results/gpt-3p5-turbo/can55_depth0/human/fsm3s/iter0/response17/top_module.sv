module top_module(
	input clk,
	input in,
	input reset,
	output out
);
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	
	reg [1:0] state, next_state;
	reg out_reg;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end
		else begin
			state <= next_state;
		end
	end
	
	always @(state, in) begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
				end
				else begin
					next_state = A;
				end
				out_reg = 0;
			end
			B: begin
				if (in) begin
					next_state = B;
				end
				else begin
					next_state = C;
				end
				out_reg = 0;
			end
			C: begin
				if (in) begin
					next_state = D;
				end
				else begin
					next_state = A;
				end
				out_reg = 0;
			end
			D: begin
				if (in) begin
					next_state = B;
				end
				else begin
					next_state = C;
				end
				out_reg = 1;
			end
			default: begin
				next_state = A;
				out_reg = 0;
			end
		endcase
	end
	
	assign out = out_reg;
	
endmodule
