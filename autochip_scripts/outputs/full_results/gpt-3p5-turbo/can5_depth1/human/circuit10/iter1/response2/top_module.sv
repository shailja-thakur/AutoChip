module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

	reg q_next;
	reg state_next;

	always @(posedge clk) begin
		q <= q_next;
		state <= state_next;
	end

	always @(*) begin
		case (state)
			0: begin
				if (a & ~b)
					begin
						q_next = 0;
						state_next = 1;
					end
				else
					begin
						q_next = 0;
						state_next = 0;
					end
			end
			1: begin
				if (a | b)
					begin
						q_next = 1;
						state_next = 1;
					end
				else
					begin
						q_next = 0;
						state_next = 0;
					end
			end
		endcase
	end

endmodule
