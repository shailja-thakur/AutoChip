module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		FLIP = 2'b01,
		ADD1 = 2'b10
	} state_t;

	state_t state, next_state;
	reg add_bit;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			IDLE: begin
				if (areset) begin
					next_state = FLIP;
				end else begin
					next_state = IDLE;
				end
			end
			FLIP: begin
				next_state = ADD1;
			end
			ADD1: begin
				next_state = ADD1;
			end
			default: begin
				next_state = IDLE;
			end
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 1'b0;
			add_bit <= 1'b0;
		end else begin
			case (state)
				IDLE: begin
					z <= 1'b0;
					add_bit <= 1'b0;
				end
				FLIP: begin
					z <= ~x;
					add_bit <= 1'b1;
				end
				ADD1: begin
					z <= x ^ add_bit;
					add_bit <= add_bit & ~x;
				end
				default: begin
					z <= 1'b0;
					add_bit <= 1'b0;
				end
			endcase
		end
	end

endmodule
