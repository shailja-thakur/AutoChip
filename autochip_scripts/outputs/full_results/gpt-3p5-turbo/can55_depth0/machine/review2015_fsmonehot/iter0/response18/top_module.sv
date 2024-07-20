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

	// Define the states
	localparam S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, Count=8, Wait=9;

	always @* begin
		// Set the default values for the next state signals
		B3_next = 0;
		S_next = 0;
		S1_next = 0;
		Count_next = 0;
		Wait_next = 0;
		
		// Check the current state and set the appropriate next state signals
		case(state)
			S: begin
				if (d == 0)
					S_next = 1;
			end
			S1: begin
				if (d == 0)
					S1_next = 1;
			end
			S110: begin
				if (d == 0)
					S_next = 1;
			end
			Wait: begin
				if (ack == 1)
					S_next = 1;
			end
			Count: begin
				if (done_counting == 1)
					Wait_next = 1;
				else if (B3 == 1)
					Count_next = 1;
			end
		endcase
		
		// Set the shift_ena signal
		shift_ena = (B3 == 1 || B2 == 1 || B1 == 1 || B0 == 1);
		
		// Set the done and counting signals
		done = (state == Wait);
		counting = (state == Count);
	end

endmodule
