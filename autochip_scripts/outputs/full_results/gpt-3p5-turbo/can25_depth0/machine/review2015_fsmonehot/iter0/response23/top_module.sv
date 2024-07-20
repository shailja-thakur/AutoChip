module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
 );

	// Define the states
	parameter S = 10'b0000000001;
	parameter S1 = 10'b0000000010;
	parameter S11 = 10'b0000000100;
	parameter S110 = 10'b0000001000;
	parameter B0 = 10'b0000010000;
	parameter B1 = 10'b0000100000;
	parameter B2 = 10'b0001000000;
	parameter B3 = 10'b0010000000;
	parameter Count = 10'b0100000000;
	parameter Wait = 10'b1000000000;

	// Declare internal signals
	reg B3_next;
	reg S_next;
	reg S1_next;
	reg Count_next;
	reg Wait_next;

	// Combinational logic to assign next state outputs
	always @*
	begin
		B3_next = (state == B2);
		S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1));
		S1_next = (state == S && d == 1);
		Count_next = (state == B3 || (state == Count && done_counting == 0));
		Wait_next = (state == Count && done_counting == 1) || (state == Wait && ack == 0);
	end

	// Assign outputs
	assign B3_next = B3_next;
	assign S_next = S_next;
	assign S1_next = S1_next;
	assign Count_next = Count_next;
	assign Wait_next = Wait_next;

	// Assign done signal
	assign done = (state == Wait);

	// Assign counting signal
	assign counting = (state == Count);

	// Assign shift_ena signal
	assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);

endmodule
