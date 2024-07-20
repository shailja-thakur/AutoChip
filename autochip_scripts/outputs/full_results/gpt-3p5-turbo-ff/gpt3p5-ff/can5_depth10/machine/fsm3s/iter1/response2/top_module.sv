module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(state or in) begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (in) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			default: next_state = A;
		endcase
	end

	always @(posedge clk) begin
		if (reset) begin
			out <= 0;
		end else begin
			out <= (state == D);
		end
	end

endmodule
