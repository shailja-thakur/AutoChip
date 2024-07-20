module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// State transition (combinational logic)
	always @(*) begin
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
			default: next_state = B;  // Default to state B
		endcase
	end

	// State update (sequential logic)
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0;  // Default to output low
		endcase
	end
endmodule
