module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	reg state, next_state;
	reg complement, next_complement;

	// State encoding
	localparam START = 1'b0;
	localparam COMPLEMENT = 1'b1;

	// State transition logic (Moore state machine)
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= START;
			complement <= 1'b0;
		end else begin
			state <= next_state;
			complement <= next_complement;
		end
	end

	// Next state logic and output logic
	always @(*) begin
		// Default assignments
		next_state = state;
		next_complement = complement;

		case (state)
			START: begin
				if (complement == 1'b0) begin
					next_state = START;
					next_complement = x ? 1'b1 : 1'b0;
					z = x;
				end else begin
					next_state = COMPLEMENT;
					next_complement = 1'b1;
					z = ~x;
				end
			end
			COMPLEMENT: begin
				next_state = COMPLEMENT;
				z = ~x;
			end
		endcase
	end
endmodule
