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
	reg B3_next;
	reg S_next;
	reg S1_next;
	reg Count_next;
	reg Wait_next;
	reg done;
	reg counting;
	reg shift_ena;
	
	always @* begin
		B3_next = (state[5] == 1) ? 1 : 0;
		S_next = ((state[0] == 1 && d == 0) || (state[2] == 1 && d == 0) || (state[3] == 1 && d == 0) || (state[9] == 1 && ack == 1)) ? 1 : 0;
		S1_next = (state[0] == 1 && d == 1) ? 1 : 0;
		Count_next = ((state[5] == 1) || (state[6] == 1 && done_counting == 0)) ? 1 : 0;
		Wait_next = ((state[6] == 1 && done_counting == 1) || (state[9] == 1 && ack == 0)) ? 1 : 0;
		shift_ena = (state[5] == 1 || state[6] == 1 || state[7] == 1 || state[8] == 1) ? 1 : 0;
		counting = (state[7] == 1) ? 1 : 0;
		done = (state[9] == 1) ? 1 : 0;
	end
	
endmodule
