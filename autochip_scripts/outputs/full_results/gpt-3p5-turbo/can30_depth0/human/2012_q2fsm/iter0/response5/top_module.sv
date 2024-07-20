module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	parameter E = 2'b100;
	parameter F = 2'b101;

	// Declare state registers
	reg [1:0] current_state;
	reg [1:0] next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// State table
	always @(current_state, w) begin
		case (current_state)
			A: begin
				if (w)
					next_state = B;
				else
					next_state = A;
			end

			B: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end

			C: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end

			D: begin
				if (w)
					next_state = F;
				else
					next_state = A;
			end

			E: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end

			F: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
		endcase
	end

	// Output logic
	always @(current_state) begin
		case (current_state)
			E: z = 1;
			default: z = 0;
		endcase
	end
endmodule
