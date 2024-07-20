module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Declare state signals
	reg [2:0] state;

	// Declare next state signals
	reg [2:0] next_state;

	// State definitions
	localparam A = 3'b000;
	localparam B = 3'b001;
	localparam C = 3'b010;
	localparam D = 3'b011;
	localparam E = 3'b100;
	localparam F = 3'b101;

	// State transition logic
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always @(state, w) begin
		case (state)
			A: begin
				if (w)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
			C: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end
			D: begin
				if (w)
					next_state = A;
				else
					next_state = F;
			end
			E: begin
				if (w)
					next_state = D;
				else
					next_state = E;
			end
			F: begin
				if (w)
					next_state = D;
				else
					next_state = C;
			end
		endcase
	end

	// Output logic
	always @(state) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 1;
			F: z = 1;
		endcase
	end

endmodule
