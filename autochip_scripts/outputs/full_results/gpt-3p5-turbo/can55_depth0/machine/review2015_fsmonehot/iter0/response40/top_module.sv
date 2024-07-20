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

	reg [9:0] next_state;
	always @(state, d) begin
		B3_next = 0;
		S_next = 0;
		S1_next = 0;
		Count_next = 0;
		Wait_next = 0;

		case(state)
			S, S1, S110, Wait:
				if (d == 0)
					S_next = 1;
			S:
				if (d == 1)
					S1_next = 1;
			B3:
				B3_next = 1;
		endcase
	end

	always @(state, done_counting) begin
		Count_next = 0;
		Wait_next = 0;
		
		case(state)
			B3:
				Count_next = 1;
			Count:
				if (done_counting == 0)
					Count_next = 1;
				else
					Wait_next = 1;
		endcase
	end

	always @(state, ack) begin
		S_next = 0;
		S1_next = 0;
		Wait_next = 0;

		case(state)
			S, S1, S110:
				if (d == 0)
					S_next = 1;
			Wait:
				if (ack == 1)
					Wait_next = 1;
		endcase
	end

	always @(state) begin
		shift_ena = 0;
		
		case(state)
			B3, B2, B1, B0:
				shift_ena = 1;
		endcase
	end

	always @(state) begin
		done = 0;
		counting = 0;
		
		if (state == Wait)
			done = 1;
		else if (state == Count)
			counting = 1;
	end

	assign next_state = state;

	always @(posedge clock) begin
		state <= next_state;
	end

endmodule
