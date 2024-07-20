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
	
	// Check if any of the states B3, B2, B1 and B0 is active
	assign shift_ena = (state & {1'b0, 4'b1111, 5'b0}) != 10'b0;
	
	// Check if state B2 is active
	assign B3_next = (state == B2);
	
	// Check if state S and d is 0, or state S1 and d is 0, or state S110 and d is 0, or state Wait and ack is 1
	assign S_next = ((state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack == 1));
	
	// Check if state S and d is 1
	assign S1_next = (state == S && d == 1);
	
	// Check if state B3 is active, or state Count and done_counting is 0
	assign Count_next = (state == B3 || (state == Count && done_counting == 0));
	
	// Check if state Count and done_counting is 1, or state Wait and ack is 0
	assign Wait_next = (state == Count && done_counting == 1) || (state == Wait && ack == 0);
	
	// Set the output signals
	assign done = (state == Wait);
	assign counting = (state == Count);
 
endmodule
