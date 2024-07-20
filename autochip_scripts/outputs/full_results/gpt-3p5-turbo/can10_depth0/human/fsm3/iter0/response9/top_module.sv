module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the state enumeration
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;

	// Define the state and output signals
	reg state_t current_state;
	reg state_t next_state;
	reg out;

	// Positive edge triggered asynchronous reset
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// State transition and output logic
	always @*
	begin
		case (current_state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 0;
			end

			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out = 0;
			end

			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out = 0;
			end

			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out = 1;
			end

			default: begin
				next_state = A;
				out = 0;
			end
		endcase
	end

	// Assign the output signal
	assign out = out;

endmodule
