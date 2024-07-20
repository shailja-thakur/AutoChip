module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

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
			A: begin
				if (in) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
		endcase
	end

	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
