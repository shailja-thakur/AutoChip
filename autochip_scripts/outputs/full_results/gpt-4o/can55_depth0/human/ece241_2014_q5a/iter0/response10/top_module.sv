module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S_INIT      = 2'b00, // Initial state
		S_COMPL_1   = 2'b01, // Complement
		S_COMPL_2   = 2'b10  // Add 1 state
	} state_t;

	state_t state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_INIT;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		case (state)
			S_INIT: begin
				if (x) begin
					next_state = S_COMPL_1;
				end else begin
					next_state = S_INIT;
				end
			end
			S_COMPL_1: begin
				next_state = S_COMPL_2;
			end
			S_COMPL_2: begin
				next_state = S_COMPL_2; // Remain in this state for subsequent bits
			end
			default: begin
				next_state = S_INIT;
			end
		endcase
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 0;
		end else begin
			case (state)
				S_INIT: begin
					z <= 0;
				end
				S_COMPL_1: begin
					z <= ~x;
				end
				S_COMPL_2: begin
					z <= ~x + 1;
				end
				default: begin
					z <= 0;
				end
			endcase
		end
	end

endmodule
