module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum logic [1:0] {IDLE=2'b00, ONES=2'b01, TWOS=2'b10, DONE=2'b11} state_t;
	state_t state, next_state;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
			z <= 0;
		end else begin
			state <= next_state;
		end
	end

	always_ff @(posedge clk) begin
		case (state)
			IDLE: begin
				if (x == 1'b1)
					next_state <= ONES;
				else
					next_state <= IDLE;
				z <= x;
			end

			ONES: begin
				next_state <= TWOS;
				z <= x;
			end

			TWOS: begin
				z <= ~x;
				next_state <= DONE;
			end

			DONE: begin
				next_state <= DONE;
				z <= ~x; // Continue outputting complemented bits
			end

			default: next_state <= IDLE;
		endcase
	end
endmodule
