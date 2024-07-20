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
				q_next = a & b;
				state_next = a | b;
			end
			1: begin
				q_next = q;
				state_next = ~a & ~b;
			end
			default: begin
				q_next = q;
				state_next = state;
			end
		endcase
	end

endmodule
