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
    output reg done,
    output reg counting,
    output reg shift_ena
 );

// States
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

// Next state assignments
wire S_next, S1_next, Count_next, Wait_next;

assign S_next = (state == S && d == 0) || (state == S1 && d == 0) || (state == S110 && d == 0) || (state == Wait && ack);
assign S1_next = (state == S && d);
assign Count_next = (state == B3) || (state == Count && done_counting == 0);
assign Wait_next = (state == Count && done_counting) || (state == Wait && ack == 0);

// Output assignments
assign B3_next = (state == B2);
assign shift_ena = (state == B3 || state == B2 || state == B1 || state == B0);
assign done = (state == Wait);
assign counting = (state == Count);

endmodule
