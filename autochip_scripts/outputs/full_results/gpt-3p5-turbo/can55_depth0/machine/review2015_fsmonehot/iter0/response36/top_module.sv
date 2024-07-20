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

	parameter S = 10'h0001;
	parameter S1 = 10'h0010;
	parameter S11 = 10'h0011;
	parameter S110 = 10'h0100;
	parameter B0 = 10'h0101;
	parameter B1 = 10'h0110;
	parameter B2 = 10'h0111;
	parameter B3 = 10'h1000;
	parameter Count = 10'h1001;
	parameter Wait = 10'h1010;
	
	always @*
	begin
		B3_next = (state == B2);
		S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1));
		S1_next = (state == S && d == 1);
		Count_next = (state == B3 || (state == Count && done_counting == 0));
		Wait_next = ((state == Count && done_counting == 1) || (state == Wait && ack == 0));
		
		done = (state == Wait);
		counting = (state == Count);
		shift_ena = ((state == B3) || (state == B2) || (state == B1) || (state == B0));
	end
	
endmodule
