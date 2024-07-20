module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output reg done,
    output reg counting,
    output reg shift_ena
 );

	// State definitions
	localparam S = 0;
	localparam S1 = 1;
	localparam S11 = 2;
	localparam S110 = 3;
	localparam B0 = 4;
	localparam B1 = 5;
	localparam B2 = 6;
	localparam B3 = 7;
	localparam Count = 8;
	localparam Wait = 9;

	// State transition logic
	always @* begin
		case(state)
			S: begin
				if (d == 0)
					S_next = 1;
				else
					S_next = 0;
				S1_next = 0;
			end
			S1: begin
				if (d == 1)
					S1_next = 1;
				else
					S1_next = 0;
				S_next = 0;
			end
			S11: begin
				S_next = 0;
				S1_next = 0;
			end
			S110: begin
				S_next = 0;
				S1_next = 0;
			end
			B0: begin
				S_next = 0;
				S1_next = 0;
			end
			B1: begin
				S_next = 0;
				S1_next = 0;
			end
			B2: begin
				if (state == 6)
					B3_next = 1;
				else
					B3_next = 0;
				S_next = 0;
				S1_next = 0;
			end
			B3: begin
				S_next = 0;
				S1_next = 0;
			end
			Count: begin
				if (done_counting == 0 || state == 7)
					Count_next = 1;
				else
					Count_next = 0;
				S_next = 0;
				S1_next = 0;
			end
			Wait: begin
				if (ack == 1 || state != 9)
					Wait_next = 0;
				else
					Wait_next = 1;
				S_next = 0;
				S1_next = 0;
			end
			default: begin
				S_next = 0;
				S1_next = 0;
			end
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		case(state)
			B3: begin
				B3_next = 1;
				B3 <= 1;
			end
			default: begin
				B3_next = 0;
				B3 <= 0;
			end
		endcase

		if ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1))
			S_next = 1;
		else
			S_next = 0;

		if (state == S && d == 1)
			S1_next = 1;
		else
			S1_next = 0;

		if (state == B3 || (state == Count && done_counting == 0))
			Count_next = 1;
		else
			Count_next = 0;

		if ((state == Count && done_counting == 1) || (state == Wait && ack == 0))
			Wait_next = 1;
		else
			Wait_next = 0;

		if (state == B3 || state == B2 || state == B1 || state == B0)
			shift_ena = 1;
		else
			shift_ena = 0;
	end

	// Done and counting signals
	assign done = (state == Wait) ? 1 : 0;
	assign counting = (state == Count) ? 1 : 0;

endmodule
