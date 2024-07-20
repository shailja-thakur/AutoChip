module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State Definitions
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;

	// State Registers
	reg [2:0] current_state;
	reg [2:0] next_state;

	// Output Register
	reg z;

	// Next State Logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Output Logic
	always @(current_state or w) begin
		case (current_state)
			A: begin
				if (w)
					next_state <= A;
				else
					next_state <= B;
			end
			B: begin
				if (w)
					next_state <= D;
				else
					next_state <= C;
			end
			C: begin
				if (w)
					next_state <= D;
				else
					next_state <= E;
			end
			D: begin
				if (w)
					next_state <= A;
				else
					next_state <= F;
			end
			E: begin
				if (w)
					next_state <= D;
				else
					next_state <= E;
			end
			F: begin
				if (w)
					next_state <= D;
				else
					next_state <= C;
			end
			default: next_state <= A;
		endcase
	end

	// Output Assignment
	always @(current_state) begin
		case (current_state)
			E: z <= 1;
			default: z <= 0;
		endcase
	end

endmodule
