module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum logic [1:0] {
		IDLE     = 2'b00,
		READ     = 2'b01,
		INVERT   = 2'b10,
		ADJUST   = 2'b11
	} state_t;

	state_t current_state, next_state;
	reg carry;
	reg invert_bit;

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= IDLE;
			z <= 1'b0;
			carry <= 1'b0;
			invert_bit <= 1'b0;
		end else begin
			current_state <= next_state;
			if (current_state == IDLE) begin
				z <= x;
			end else if (current_state == INVERT) begin
				invert_bit <= ~x;
			end else if (current_state == ADJUST) begin
				if (x == 1'b0) begin
					carry <= 1'b1;
				end
				z <= invert_bit + carry;
			end
		end
	end

	always_comb begin
		next_state = current_state;
		case (current_state)
			IDLE: begin
				if (!areset) next_state = READ;
			end
			READ: begin
				next_state = INVERT;
			end
			INVERT: begin
				next_state = ADJUST;
			end
			ADJUST: begin
				next_state = READ;
			end
		endcase
	end
endmodule
