module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;

	reg [1:0] state, next_state;
	reg out_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(state, in) begin
		case (state)
			A: begin
				if (in == 0) begin
					next_state = A;
					out_reg = 0;
				end else begin
					next_state = B;
					out_reg = 0;
				end
			end

			B: begin
				if (in == 0) begin
					next_state = C;
					out_reg = 0;
				end else begin
					next_state = B;
					out_reg = 0;
				end
			end

			C: begin
				if (in == 0) begin
					next_state = A;
					out_reg = 0;
				end else begin
					next_state = D;
					out_reg = 0;
				end
			end
			
			D: begin
				if (in == 0) begin
					next_state = C;
					out_reg = 1;
				end else begin
					next_state = B;
					out_reg = 1;
				end
			end
		endcase
	end

	assign out = out_reg;

endmodule
