module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State declaration
	enum logic [1:0] state, next_state;
    parameter S = 2'b00, S1 = 2'b01, S10 = 2'b10;

	// State register
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case ({x, state})
			2'b00_00: next_state = S;
			2'b01_00: next_state = S1;
			2'b00_01: next_state = S10;
			2'b01_01: next_state = S1;
			2'b00_10: next_state = S;
			2'b01_10: next_state = S1;
			default: next_state = S;
		endcase
	end

	// Output logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			z <= 1'b0;
		end else begin
			case (state)
				S, S1: z <= 1'b0;
				S10: z <= x;
			endcase
		end
	end

endmodule
