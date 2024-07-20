module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	// State declaration using one-hot encoding
	reg [1:0] state;
	reg [1:0] next_state;

	// State encoding
	localparam STATE_A = 2'b01;
	localparam STATE_B = 2'b10;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_A; // Async reset to state A
		else
			state <= next_state;
	end

	// Next state logic and output logic
	always @(*) begin
		case(state)
			STATE_A: begin
				if (x) begin
					next_state = STATE_B;
					z = 1;
				end else begin
					next_state = STATE_A;
					z = 0;
				end
			end
			STATE_B: begin
				if (x) begin
					next_state = STATE_B;
					z = 0;
				end else begin
					next_state = STATE_B;
					z = 1;
				end
			end
			default: begin
				next_state = STATE_A; // Default to state A
				z = 0;
			end
		endcase
	end
endmodule
