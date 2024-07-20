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

	// Declare state variables
	reg [8:0] state;
	reg [8:0] next_state;

	// Initial value for state
	initial
	begin
		state = A;
	end

	// Sequential logic for state transition
	always @(posedge clk)
	begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Combinational logic for next state calculation
	always @*
	begin
		case (state)
			A:
			begin
				if (w)
					next_state = B;
				else
					next_state = A;
			end

			B:
			begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end

			C:
			begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end

			D:
			begin
				if (w)
					next_state = F;
				else
					next_state = A;
			end

			E:
			begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end

			F:
			begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
		endcase
	end

	// Output logic
	always @*
	begin
		case (state)
			A, B, C, D, E: z = 0;
			F: z = 1;
			default: z = 0;
		endcase
	end

endmodule
