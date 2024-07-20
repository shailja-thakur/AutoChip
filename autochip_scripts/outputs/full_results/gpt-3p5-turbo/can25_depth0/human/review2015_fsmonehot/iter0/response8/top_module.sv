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
 
 // State transition equations
 assign B3_next = (state == 10'b0000000001);
 assign S_next = (d == 1'b0) ? state & (10'b1111111110) : (d == 1'b1) ? state & (10'b1111111101) : 0;
 assign S1_next = (d == 1'b0) ? state & (10'b1111111101) : (d == 1'b1) ? state & (10'b1111111011) : 0;
 assign Count_next = (state == 10'b1000000000) ? (done_counting == 1'b0) ? state : 0 : (state == 10'b1000000001) ? (done_counting == 1'b0) ? state : 0 : 0;
 assign Wait_next = (state == 10'b1000000001) ? (done_counting == 1'b1) ? state : 0 : (state == 10'b1000000100) ? (done_counting == 1'b1) ? state : 0 : 0;
 
 // Output logic equations
 assign done = (state == 10'b1000000100 && ack == 1'b0) ? 1'b1 : (state == 10'b1000000100 && ack == 1'b1) ? 1'b0 : 1'b0;
 assign counting = (state == 10'b1000000000 || state == 10'b1000000001 || state == 10'b1000000100) ? 1'b1 : 1'b0;
 assign shift_ena = (state == 10'b1000000100 || state == 10'b1000001000 || state == 10'b1000010000 || state == 10'b1000100000) ? 1'b1 : 1'b0;
 
endmodule
